//
//  ELF32HashTable.swift
//
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation
import ELFKitC

public struct ELF32HashTable: ELFHashTableProtocol {
    public typealias Header = ELF32HashTableHeader
    public typealias Hashelt = Elf32_Hashelt

    public let header: Header

    public let buckets: [Hashelt]
    public let chains: [Hashelt]
}

public struct ELF64HashTable: ELFHashTableProtocol {
    public typealias Header = ELF64HashTableHeader
    public typealias Hashelt = Elf64_Hashelt

    public let header: Header

    public let buckets: [Hashelt]
    public let chains: [Hashelt]
}
