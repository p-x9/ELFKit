//
//  ELFHashTableProtocol.swift
//  
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation

public protocol ELFHashTableHeaderProtocol {
    var numberOfBuckets: Int { get }
    var numberOfChains: Int { get }
}

public protocol ELFHashTableProtocol {
    associatedtype Header: ELFHashTableHeaderProtocol
    associatedtype Hashelt: FixedWidthInteger

    var header: Header { get }
    var buckets: [Hashelt] { get }
    var chains: [Hashelt] { get }

    init(header: Header, buckets: [Hashelt], chains: [Hashelt])
}

public protocol ELFGnuHashTableProtocol {
    associatedtype Hashelt: FixedWidthInteger
    associatedtype Bloom: FixedWidthInteger

    var header: ELFGnuHashTableHeader { get }

    var bloom: [Bloom] { get }
    var buckets: [Hashelt] { get }

    var chainsOffset: Int { get }

    init(header: ELFGnuHashTableHeader, bloom: [Bloom], buckets: [Hashelt], chainsOffset: Int)
}

extension ELFGnuHashTableProtocol {
    func numberOfSymbols(in elf: ELFFile) -> Int? {
        // https://flapenguin.me/elf-dt-gnu-hash
        guard let maxBucket = buckets.max() else {
            return nil
        }
        var ix: UInt32 = numericCast(maxBucket)
        var chain: Hashelt = elf.fileHandle.read(
            offset: numericCast(chainsOffset) 
            + numericCast(ix - header.gh_symndx) * numericCast(MemoryLayout<Hashelt>.size)
        )
        while (chain & 1) == 0 {
            ix += 1
            chain = elf.fileHandle.read(
                offset: numericCast(chainsOffset)
                + numericCast(ix - header.gh_symndx) * numericCast(MemoryLayout<Hashelt>.size)
            )
        }
        return numericCast(ix) + 1 // First `STN_UNDEF` symbol
    }
}

extension ELFGnuHashTableProtocol {
    public static func hash(for name: String) -> Int {
        let cString = name.cString(using: .utf8)
        var h: UInt = 5381

        if let cString {
            for ch in cString where ch != 0 {
                h = h &* 33 + UInt(ch)
            }
        }

        return numericCast(h & 0xffffffff)
    }
}

extension ELFGnuHashTableProtocol {
    // ref: https://flapenguin.me/elf-dt-gnu-hash
    // ref: https://github.com/bminor/glibc/blob/ea73eb5f581ef5931fd67005aa0c526ba43366c9/elf/dl-lookup.c#L340
    public func findSymbol64(
        named symbol: String,
        in elf: ELFFile
    ) -> ELF64Symbol? {
        guard let dynamics = elf.dynamics64,
              let hashTable = dynamics.gnuHashTable(in: elf),
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        let header = hashTable.header
        let bits = 64

        let hash = Self.hash(for: symbol)

        let word = hashTable.bloom[(hash / bits) % numericCast(header.gh_maskwords)]
        let mask: UInt64 = 0 | 1 << (hash % bits) | 1 << ((hash >> UInt64(header.gh_shift2)) % bits)

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
            let nhash: UInt32 = elf.fileHandle.read(
                offset: numericCast( hashTable.chainsOffset) + numericCast(MemoryLayout<Hashelt>.size) * numericCast(symix - header.gh_symndx))
            if (hash|1) == (nhash|1) && name == symbol {
               return current
            }
            if (hash & 1) != 0 { break }
            symix += 1
        }

        return nil
    }

    public func findSymbol32(
        named symbol: String,
        in elf: ELFFile
    ) -> ELF32Symbol? {
        guard let dynamics = elf.dynamics32,
              let hashTable = dynamics.gnuHashTable(in: elf),
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        let header = hashTable.header
        let bits = 32

        let hash = Self.hash(for: symbol)

        let word = hashTable.bloom[(hash / bits) % numericCast(header.gh_maskwords)]
        let mask: UInt32 = 0 | 1 << (hash % bits) | 1 << ((hash >> UInt32(header.gh_shift2)) % bits)

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
            let nhash: UInt32 = elf.fileHandle.read(
                offset: numericCast( hashTable.chainsOffset) + numericCast(MemoryLayout<Hashelt>.size) * numericCast(symix - header.gh_symndx))
            if (hash|1) == (nhash|1) && name == symbol {
                return current
            }
            if (hash & 1) != 0 { break }
            symix += 1
        }

        return nil
    }

    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> (any ELFSymbolProtocol)? {
        if elf.is64Bit {
            findSymbol64(named: symbol, in: elf)
        } else {
            findSymbol32(named: symbol, in: elf)
        }
    }
}

