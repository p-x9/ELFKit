//
//  ELF64Dynamic.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public struct ELF64Dynamic: LayoutWrapper, Sendable {
    public typealias Layout = Elf64_Dyn

    public typealias HashTable = ELF64HashTable
    public typealias GnuHashTable = ELF64GnuHashTable
    public typealias Symbol = ELF64Symbol
    public typealias Relocation = ELF64Relocation
    public typealias SymbolInfo = ELF64SymbolInfo
    public typealias VersionDef = ELF64VersionDef
    public typealias VersionNeed = ELF64VersionNeed
    public typealias VersionSym = ELF64VersionSym

    public var layout: Layout
}

extension ELF64Dynamic: ELFDynamicProtocol {
    public var _commonTag: DynamicTag? {
        .init(
            rawValue: numericCast(layout.d_tag),
            osabi: .none,
            machine: .none
        )
    }

    public func tag(inELF header: ELFHeader) -> DynamicTag? {
        .init(
            rawValue: numericCast(layout.d_tag),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var value: Int {
        numericCast(layout.d_un.d_val)
    }

    public var pointer: Int {
        numericCast(layout.d_un.d_ptr)
    }
}
