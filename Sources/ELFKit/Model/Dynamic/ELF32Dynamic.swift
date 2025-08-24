//
//  ELF32Dynamic.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public struct ELF32Dynamic: LayoutWrapper, Sendable {
    public typealias Layout = Elf32_Dyn

    public typealias HashTable = ELF32HashTable
    public typealias GnuHashTable = ELF32GnuHashTable
    public typealias Symbol = ELF32Symbol
    public typealias Relocation = ELF32Relocation
    public typealias SymbolInfo = ELF32SymbolInfo
    public typealias VersionDef = ELF32VersionDef
    public typealias VersionNeed = ELF32VersionNeed
    public typealias VersionSym = ELF32VersionSym

    public var layout: Layout
}

extension ELF32Dynamic: ELFDynamicProtocol {
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
