//
//  ELFHashTableHeader.swift
//  
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation
import ELFKitC

public struct ELF32HashTableHeader: LayoutWrapper {
    public struct Layout {
        public let nbuckets: Elf32_Hashelt
        public let nchain: Elf32_Hashelt
    }
    public var layout: Layout
}

public struct ELF64HashTableHeader: LayoutWrapper {
    public struct Layout {
        public let nbuckets: Elf64_Hashelt
        public let nchain: Elf64_Hashelt
    }
    public var layout: Layout
}

extension ELF32HashTableHeader: ELFHashTableHeaderProtocol {
    public var numberOfBuckets: Int {
        numericCast(layout.nbuckets)
    }

    public var numberOfChains: Int {
        numericCast(layout.nchain)
    }
}

extension ELF64HashTableHeader: ELFHashTableHeaderProtocol {
    public var numberOfBuckets: Int {
        numericCast(layout.nbuckets)
    }

    public var numberOfChains: Int {
        numericCast(layout.nchain)
    }
}

extension ELFHashTableHeaderProtocol where Self: LayoutWrapper {
    func _readContent<Table: ELFHashTableProtocol>(
        in elf: ELFFile,
        at offset: Int
    ) -> Table where Table.Header == Self {
        var header: Self { self }

        let bucketStart: Int = numericCast(offset) + numericCast(header.layoutSize)
        let buckets: DataSequence<Table.Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(bucketStart),
            numberOfElements: header.numberOfBuckets
        )

        let chainStart: Int = bucketStart + buckets.size
        let chains: DataSequence<Table.Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(chainStart),
            numberOfElements: header.numberOfChains
        )
        return .init(
            header: header,
            buckets: Array(buckets),
            chains: Array(chains)
        )
    }

    func _readContent<Table: ELFHashTableProtocol>(
        in elf: ELFImage,
        at offset: Int
    ) -> Table where Table.Header == Self {
        var header: Self { self }

        let bucketStart: Int = numericCast(offset) + numericCast(header.layoutSize)

        let buckets: MemorySequence<Table.Hashelt> = .init(
            basePointer: elf.ptr
                .advanced(by: bucketStart)
                .assumingMemoryBound(to: Table.Hashelt.self),
            numberOfElements: header.numberOfBuckets
        )

        let chainStart: Int = bucketStart + buckets.size
        let chains: MemorySequence<Table.Hashelt> = .init(
            basePointer: elf.ptr
                .advanced(by: chainStart)
                .assumingMemoryBound(to: Table.Hashelt.self),
            numberOfElements: header.numberOfChains
        )

        return .init(
            header: header,
            buckets: Array(buckets),
            chains: Array(chains)
        )
    }
}
