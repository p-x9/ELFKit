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
    public typealias Symbol = ELF32Symbol

    public let header: Header

    public let buckets: [Hashelt]
    public let chains: [Hashelt]

    public init(
        header: Header,
        buckets: [Hashelt],
        chains: [Hashelt]
    ) {
        self.header = header
        self.buckets = buckets
        self.chains = chains
    }
}

public struct ELF64HashTable: ELFHashTableProtocol {
    public typealias Header = ELF64HashTableHeader
    public typealias Hashelt = Elf64_Hashelt
    public typealias Symbol = ELF64Symbol

    public let header: Header

    public let buckets: [Hashelt]
    public let chains: [Hashelt]

    public init(
        header: Header,
        buckets: [Hashelt],
        chains: [Hashelt]
    ) {
        self.header = header
        self.buckets = buckets
        self.chains = chains
    }
}

extension ELF32HashTable {
    // ref: https://flapenguin.me/elf-dt-hash
    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> Symbol? {
        guard let dynamics = elf.dynamics32,
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        let hashTable = self
        let header = hashTable.header

        let hash = Self.hash(for: symbol)

        var symix = hashTable.buckets[hash % header.numberOfBuckets]
        while true {
            let current = symbols[Int(symix)]
            let name = current.name(in: elf, isDynamic: true)
            if name == symbol {
                return current
            }
            if current._commonSpecialSection == .undef {
                break
            }
            symix = hashTable.chains[Int(symix)]
        }
        return nil
    }
}

extension ELF64HashTable {
    // ref: https://flapenguin.me/elf-dt-hash
    public func findSymbol(
        named symbol: String,
        in elf: ELFFile
    ) -> Symbol? {
        guard let dynamics = elf.dynamics64,
              let symbols = dynamics.symbols(in: elf) else {
            return nil
        }
        let hashTable = self
        let header = hashTable.header

        let hash = Self.hash(for: symbol)

        var symix = hashTable.buckets[hash % header.numberOfBuckets]
        while true {
            let current = symbols[Int(symix)]
            let name = current.name(in: elf, isDynamic: true)
            if name == symbol {
                return current
            }
            if current._commonSpecialSection == .undef {
                break
            }
            symix = hashTable.chains[Int(symix)]
        }
        return nil
    }
}
