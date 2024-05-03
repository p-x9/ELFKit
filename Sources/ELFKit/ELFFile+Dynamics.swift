//
//  ELFFile+Dynamics.swift
//
//
//  Created by p-x9 on 2024/05/02
//  
//

import Foundation
import ELFKitC

extension ELFFile {
    public struct Dynamics32: ELFFileDynamicsSequence {
        public typealias Dynamic = ELF32Dynamic

        public typealias Element = ELF32Dynamic
        public typealias Iterator = DataSequence<Dynamic>.Iterator

        public typealias HashTableHeader = ELF32HashTableHeader
        public typealias HashTable = ELF32HashTable
        public typealias GnuHashTable = ELF32GnuHashTable
        public typealias Symbol = ELF32Symbol
        public typealias Relocation = ELF32Relocation
        public typealias SymbolInfo = ELF32SymbolInfo
        public typealias VersionDef = ELF32VersionDef
        public typealias VersionNeed = ELF32VersionNeed
        public typealias VersionSym = ELF32VersionSym

        public let sequence: WrappedSequence

        public init(_ sequence: WrappedSequence) {
            self.sequence = sequence
        }
    }

    public struct Dynamics64: ELFFileDynamicsSequence {
        public typealias Dynamic = ELF64Dynamic
        public typealias Element = ELF64Dynamic
        public typealias Iterator = DataSequence<Dynamic>.Iterator

        public typealias HashTableHeader = ELF64HashTableHeader
        public typealias HashTable = ELF64HashTable
        public typealias GnuHashTable = ELF64GnuHashTable
        public typealias Symbol = ELF64Symbol
        public typealias Relocation = ELF64Relocation
        public typealias SymbolInfo = ELF64SymbolInfo
        public typealias VersionDef = ELF64VersionDef
        public typealias VersionNeed = ELF64VersionNeed
        public typealias VersionSym = ELF64VersionSym

        public let sequence: WrappedSequence

        public init(_ sequence: WrappedSequence) {
            self.sequence = sequence
        }
    }
}
