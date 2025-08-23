//
//  ELFSymbol.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public struct ELF32Symbol: LayoutWrapper, Sendable {
    public typealias Layout = Elf32_Sym

    public var layout: Layout
}

public struct ELF64Symbol: LayoutWrapper, Sendable {
    public typealias Layout = Elf64_Sym

    public var layout: Layout
}

extension ELF32Symbol: ELFSymbolProtocol {
    public var nameOffset: Int {
        numericCast(layout.st_name)
    }

    public var _commonBinding: SymbolBinding? {
        // ELF32_ST_BIND
        .init(
            rawValue: numericCast(layout.st_info >> 4),
            osabi: .none
        )
    }

    public func binding(inELF header: ELFHeader) -> SymbolBinding? {
        // ELF32_ST_BIND
        .init(
            rawValue: numericCast(layout.st_info >> 4),
            osabi: header.osABI ?? .none
        )
    }

    public var _commonType: SymbolType? {
        // ELF32_ST_TYPE
        .init(
            rawValue: numericCast(layout.st_info & 0xf),
            osabi: .none,
            machine: .none
        )
    }

    public func type(inELF header: ELFHeader) -> SymbolType? {
        .init(
            rawValue: numericCast(layout.st_info & 0xf),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var visibility: SymbolVisibility! {
        // ELF32_ST_VISIBILITY
        .init(rawValue: layout.st_other & 0x3)
    }

    public var sectionIndex: Int? {
        let SHN_LORESERVE = 0xff00
        guard numericCast(layout.st_shndx) < SHN_LORESERVE else { return nil }
        return numericCast(layout.st_shndx)
    }

    public var _commonSpecialSection: SpecialSectionIndex? {
        .init(
            rawValue: numericCast(layout.st_shndx),
            osabi: .none,
            machine: .none
        )
    }

    public func specialSection(inELF header: ELFHeader) -> SpecialSectionIndex? {
        .init(
            rawValue: numericCast(layout.st_shndx),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }
}

extension ELF64Symbol: ELFSymbolProtocol {
    public var nameOffset: Int {
        numericCast(layout.st_name)
    }

    public var _commonBinding: SymbolBinding? {
        // ELF64_ST_BIND
        .init(
            rawValue: numericCast(layout.st_info >> 4),
            osabi: .none
        )
    }

    public func binding(inELF header: ELFHeader) -> SymbolBinding? {
        // ELF64_ST_BIND
        .init(
            rawValue: numericCast(layout.st_info >> 4),
            osabi: header.osABI ?? .none
        )
    }

    public var _commonType: SymbolType? {
        // ELF64_ST_TYPE
        .init(
            rawValue: numericCast(layout.st_info & 0xf),
            osabi: .none,
            machine: .none
        )
    }

    public func type(inELF header: ELFHeader) -> SymbolType? {
        .init(
            rawValue: numericCast(layout.st_info & 0xf),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var visibility: SymbolVisibility! {
        // ELF64_ST_VISIBILITY
        .init(rawValue: layout.st_other & 0x3)
    }

    public var sectionIndex: Int? {
        let SHN_LORESERVE = 0xff00
        guard numericCast(layout.st_shndx) < SHN_LORESERVE else { return nil }
        return numericCast(layout.st_shndx)
    }

    public var _commonSpecialSection: SpecialSectionIndex? {
        .init(
            rawValue: numericCast(layout.st_shndx),
            osabi: .none,
            machine: .none
        )
    }

    public func specialSection(inELF header: ELFHeader) -> SpecialSectionIndex? {
        .init(
            rawValue: numericCast(layout.st_shndx),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }
}
