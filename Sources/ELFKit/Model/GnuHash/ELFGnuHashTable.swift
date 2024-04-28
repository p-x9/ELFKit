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

    public let header: ELFGnuHashTableHeader

    public let bloom: [Bloom]
    public let buckets: [Hashelt]
//    public let chains: [Hashelt]
    public let chainsOffset: Int
}

public struct ELF64GnuHashTable: ELFGnuHashTableProtocol {
    public typealias Hashelt = Elf64_Hashelt
    public typealias Bloom = UInt64

    public let header: ELFGnuHashTableHeader

    public let bloom: [Bloom]
    public let buckets: [Hashelt]
//    public let chains: [Hashelt]
    public let chainsOffset: Int
}
