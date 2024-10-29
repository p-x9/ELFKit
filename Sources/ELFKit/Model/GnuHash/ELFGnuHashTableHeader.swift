//
//  ELFGnuHashTableHeader.swift
//
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation

public struct ELFGnuHashTableHeader: LayoutWrapper {
    public typealias Layout = Elf_GNU_Hash_Header
    public var layout: Layout
}

extension ELFGnuHashTableHeader {
    func _readContent<Table: ELFGnuHashTableProtocol>(
        in elf: ELFFile,
        at offset: Int
    ) -> Table {
        var header: Self { self }
        let bloomsStart: Int = numericCast(offset) + numericCast(header.layoutSize)
        let blooms: DataSequence<Table.Bloom> = elf.fileHandle.readDataSequence(
            offset: numericCast(bloomsStart),
            numberOfElements: numericCast(header.gh_maskwords)
        )

        let bucketsStart: Int = bloomsStart + blooms.size
        let buckets: DataSequence<Table.Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(bucketsStart),
            numberOfElements: numericCast(header.gh_nbuckets)
        )

        let chainsOffset = bucketsStart + buckets.size

        return .init(
            header: header,
            bloom: Array(blooms),
            buckets: Array(buckets),
            chainsOffset: chainsOffset
        )
    }
}
