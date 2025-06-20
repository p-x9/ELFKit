//
//  ELFGnuHashTable.swift
//
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation
import ELFKitC

public struct ELF32GnuHashTable: ELFGnuHashTableProtocol {
    public typealias Hashelt = Elf32_Hashelt
    public typealias Bloom = UInt32
    public typealias Symbol = ELF32Symbol

    public let header: ELFGnuHashTableHeader

    public let bloom: [Bloom]
    public let buckets: [Hashelt]
//    public let chains: [Hashelt]
    public let chainsOffset: Int

    public init(
        header: ELFGnuHashTableHeader,
        bloom: [Bloom],
        buckets: [Hashelt],
        chainsOffset: Int
    ) {
        self.header = header
        self.bloom = bloom
        self.buckets = buckets
        self.chainsOffset = chainsOffset
    }
}

public struct ELF64GnuHashTable: ELFGnuHashTableProtocol {
    public typealias Hashelt = Elf64_Hashelt
    public typealias Bloom = UInt64
    public typealias Symbol = ELF64Symbol

    public let header: ELFGnuHashTableHeader

    public let bloom: [Bloom]
    public let buckets: [Hashelt]
//    public let chains: [Hashelt]
    public let chainsOffset: Int

    public init(
        header: ELFGnuHashTableHeader,
        bloom: [Bloom],
        buckets: [Hashelt],
        chainsOffset: Int
    ) {
        self.header = header
        self.bloom = bloom
        self.buckets = buckets
        self.chainsOffset = chainsOffset
    }
}

extension ELF32GnuHashTable {
    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> Symbol? {
        guard let dynamics = elf.dynamics32,
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        return _findSymbol(
            named: symbol,
            in: elf,
            bits: 32,
            symbols: symbols
        )
    }

    public func findSymbol(
        named symbol: String,
        in elf: ELFImage
    ) -> Symbol? {
        guard let dynamics = elf.dynamics32,
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        return _findSymbol(
            named: symbol,
            in: elf,
            bits: 32,
            symbols: symbols
        )
    }
}

extension ELF64GnuHashTable {
    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> Symbol? {
        guard let dynamics = elf.dynamics64,
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        return _findSymbol(
            named: symbol,
            in: elf,
            bits: 64,
            symbols: symbols
        )
    }

    public func findSymbol(
        named symbol: String,
        in elf: ELFImage
    ) -> Symbol? {
        guard let dynamics = elf.dynamics64,
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        return _findSymbol(
            named: symbol,
            in: elf,
            bits: 64,
            symbols: symbols
        )
    }
}

fileprivate extension ELFGnuHashTableProtocol {
    // ref: https://flapenguin.me/elf-dt-gnu-hash
    // ref: https://github.com/bminor/glibc/blob/ea73eb5f581ef5931fd67005aa0c526ba43366c9/elf/dl-lookup.c#L340
    func _findSymbol(
        named symbol: String,
        in elf: ELFFile,
        bits: Int,
        symbols: DataSequence<Symbol>
    ) -> Symbol? {
        let hashTable = self
        let header = hashTable.header

        let hash = Self.hash(for: symbol)

        let word = hashTable.bloom[(hash / bits) % numericCast(header.gh_maskwords)]
        let mask: Bloom = 0 | 1 << (hash % bits) | 1 << ((hash >> Bloom(header.gh_shift2)) % bits)

        if (word & mask) != mask {
            // Symbol Not Found"
            return nil
        }

        var symix = hashTable.buckets[hash % numericCast(header.gh_nbuckets)]
        if symix < numericCast(header.gh_symndx) {
            // Symbol Not Found
            return nil
        }

        while true {
            let current = symbols[Int(symix)]
            let name = current.name(in: elf, isDynamic: true)
            let nhash: UInt32 = try! elf.fileHandle.read(
                offset: hashTable.chainsOffset + MemoryLayout<Hashelt>.size * numericCast(UInt32(symix) - header.gh_symndx))
            if (hash | 1) == (nhash | 1) && name == symbol {
                return current
            }
            if (hash & 1) != 0 { break }
            symix += 1
        }

        return nil
    }

    func _findSymbol(
        named symbol: String,
        in elf: ELFImage,
        bits: Int,
        symbols: MemorySequence<Symbol>
    ) -> Symbol? {
        let hashTable = self
        let header = hashTable.header

        let hash = Self.hash(for: symbol)

        let word = hashTable.bloom[(hash / bits) % numericCast(header.gh_maskwords)]
        let mask: Bloom = 0 | 1 << (hash % bits) | 1 << ((hash >> Bloom(header.gh_shift2)) % bits)

        if (word & mask) != mask {
            // Symbol Not Found"
            return nil
        }

        var symix = hashTable.buckets[hash % numericCast(header.gh_nbuckets)]
        if symix < numericCast(header.gh_symndx) {
            // Symbol Not Found
            return nil
        }

        while true {
            let current = symbols[Int(symix)]
            let name = current.name(in: elf, isDynamic: true)
            let nhash: UInt32 = elf.ptr
                .advanced(
                    by: numericCast( hashTable.chainsOffset) + numericCast(MemoryLayout<Hashelt>.size) * numericCast(UInt32(symix) - header.gh_symndx)
                )
                .autoBoundPointee()
            if (hash | 1) == (nhash | 1) && name == symbol {
                return current
            }
            if (hash & 1) != 0 { break }
            symix += 1
        }

        return nil
    }
}
