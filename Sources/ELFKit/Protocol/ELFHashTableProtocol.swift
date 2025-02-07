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
    associatedtype Symbol: ELFSymbolProtocol

    var header: Header { get }
    var buckets: [Hashelt] { get }
    var chains: [Hashelt] { get }

    init(header: Header, buckets: [Hashelt], chains: [Hashelt])

    func findSymbol(named symbol: String, in elf: ELFFile) -> Symbol?

    static func hash(for name: String) -> Int
}

extension ELFHashTableProtocol {
    public static func hash(for name: String) -> Int {
        let cString = name.cString(using: .utf8)
        var h: UInt = 0

        if let cString {
            for ch in cString where ch != 0 {
                h = (h &<< 4) + UInt(ch)
                let g = h & 0xf0000000
                if g > 0 {
                    h ^= g &>> 24
                }
                h &= ~g
            }
        }

        return numericCast(h)
    }
}

extension ELFHashTableProtocol {
    @_disfavoredOverload
    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> (any ELFSymbolProtocol)? {
        findSymbol(named: symbol, in: elf)
    }
}

public protocol ELFGnuHashTableProtocol {
    associatedtype Hashelt: FixedWidthInteger
    associatedtype Bloom: FixedWidthInteger
    associatedtype Symbol: ELFSymbolProtocol

    var header: ELFGnuHashTableHeader { get }

    var bloom: [Bloom] { get }
    var buckets: [Hashelt] { get }

    var chainsOffset: Int { get }

    init(header: ELFGnuHashTableHeader, bloom: [Bloom], buckets: [Hashelt], chainsOffset: Int)

    func findSymbol(named symbol: String, in elf: ELFFile) -> Symbol?

    static func hash(for name: String) -> Int
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

    func numberOfSymbols(in elf: ELFImage) -> Int? {
        // https://flapenguin.me/elf-dt-gnu-hash
        guard let maxBucket = buckets.max() else {
            return nil
        }
        var ix: UInt32 = numericCast(maxBucket)
        var chain: Hashelt = elf.ptr
            .advanced(
                by: numericCast(chainsOffset)
                      + numericCast(ix - header.gh_symndx) * numericCast(MemoryLayout<Hashelt>.size)
            )
            .autoBoundPointee()
        while (chain & 1) == 0 {
            ix += 1
            chain = elf.ptr
                .advanced(
                    by: numericCast(chainsOffset)
                          + numericCast(ix - header.gh_symndx) * numericCast(MemoryLayout<Hashelt>.size)
                )
                .autoBoundPointee()
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
    @_disfavoredOverload
    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> (any ELFSymbolProtocol)? {
        findSymbol(named: symbol, in: elf)
    }
}
