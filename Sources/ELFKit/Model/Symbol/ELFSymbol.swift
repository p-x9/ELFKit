//
//  ELFSymbol.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public struct ELF32Symbol: LayoutWrapper {
    public typealias Layout = Elf32_Sym

    public var layout: Layout
}

public struct ELF64Symbol: LayoutWrapper {
    public typealias Layout = Elf64_Sym

    public var layout: Layout
}

extension ELF32Symbol: ELFSymbolProtocol {
    public var nameOffset: Int {
        numericCast(layout.st_name)
    }

    public var binding: SymbolBinding! {
        // ELF32_ST_BIND
        .init(rawValue: numericCast(layout.st_info >> 4))
    }

    public var type: SymbolType! {
        // ELF32_ST_TYPE
        .init(rawValue: numericCast(layout.st_info & 0xf))
    }

    public var visibility: SymbolVisibility! {
        // ELF32_ST_VISIBILITY
        .init(rawValue: layout.st_other & 0x3)
    }

    public var sectionIndex: Int? {
        specialSection == nil ? numericCast(layout.st_shndx) : 0
    }

    public var specialSection: SpecialSectionIndex? {
        .init(rawValue: numericCast(layout.st_shndx))
    }
}

extension ELF64Symbol: ELFSymbolProtocol {
    public var nameOffset: Int {
        numericCast(layout.st_name)
    }

    public var binding: SymbolBinding! {
        // ELF64_ST_BIND
        .init(rawValue: numericCast(layout.st_info >> 4))
    }

    public var type: SymbolType! {
        // ELF64_ST_TYPE
        .init(rawValue: numericCast(layout.st_info & 0xf))
    }

    public var visibility: SymbolVisibility! {
        // ELF64_ST_VISIBILITY
        .init(rawValue: layout.st_other & 0x3)
    }

    public var sectionIndex: Int? {
        specialSection == nil ? numericCast(layout.st_shndx) : 0
    }

    public var specialSection: SpecialSectionIndex? {
        .init(rawValue: numericCast(layout.st_shndx))
    }
}
