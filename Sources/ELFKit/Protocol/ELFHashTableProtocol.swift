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
