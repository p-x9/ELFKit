//
//  ELFSymbolInfo.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct ELF32SymbolInfo: LayoutWrapper {
    public typealias Layout = Elf32_Syminfo

    public var layout: Layout
}

public struct ELF64SymbolInfo: LayoutWrapper {
    public typealias Layout = Elf64_Syminfo

    public var layout: Layout
}

extension ELF32SymbolInfo: ELFSymbolInfoProtocol {
    public var dynamicEntryIndex: Int? {
        specialBound == nil ? numericCast(layout.si_boundto) : nil
    }

    public var specialBound: SymbolInfoSpecialBound? {
        .init(rawValue: layout.si_boundto)
    }

    public var flags: SymbolInfoFlags {
        .init(rawValue: layout.si_flags)
    }
}

extension ELF64SymbolInfo: ELFSymbolInfoProtocol {
    public var dynamicEntryIndex: Int? {
        specialBound == nil ? numericCast(layout.si_boundto) : nil
    }

    public var specialBound: SymbolInfoSpecialBound? {
        .init(rawValue: layout.si_boundto)
    }

    public var flags: SymbolInfoFlags {
        .init(rawValue: layout.si_flags)
    }
}
