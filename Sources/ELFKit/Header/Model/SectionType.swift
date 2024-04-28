//
//  SectionType.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
import ELFKitC

public enum SectionType: CaseIterable {
    /// SHT_NULL
    case null
    /// SHT_PROGBITS
    case progbits
    /// SHT_SYMTAB
    case symtab
    /// SHT_STRTAB
    case strtab
    /// SHT_RELA
    case rela
    /// SHT_HASH
    case hash
    /// SHT_DYNAMIC
    case dynamic
    /// SHT_NOTE
    case note
    /// SHT_NOBITS
    case nobits
    /// SHT_REL
    case rel
    /// SHT_SHLIB
    case shlib
    /// SHT_DYNSYM
    case dynsym
    /// SHT_INIT_ARRAY
    case init_array
    /// SHT_FINI_ARRAY
    case fini_array
    /// SHT_PREINIT_ARRAY
    case preinit_array
    /// SHT_GROUP
    case group
    /// SHT_SYMTAB_SHNDX
    case symtab_shndx
}

extension SectionType: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_NULL): self = .null
        case RawValue(SHT_PROGBITS): self = .progbits
        case RawValue(SHT_SYMTAB): self = .symtab
        case RawValue(SHT_STRTAB): self = .strtab
        case RawValue(SHT_RELA): self = .rela
        case RawValue(SHT_HASH): self = .hash
        case RawValue(SHT_DYNAMIC): self = .dynamic
        case RawValue(SHT_NOTE): self = .note
        case RawValue(SHT_NOBITS): self = .nobits
        case RawValue(SHT_REL): self = .rel
        case RawValue(SHT_SHLIB): self = .shlib
        case RawValue(SHT_DYNSYM): self = .dynsym
        case RawValue(SHT_INIT_ARRAY): self = .init_array
        case RawValue(SHT_FINI_ARRAY): self = .fini_array
        case RawValue(SHT_PREINIT_ARRAY): self = .preinit_array
        case RawValue(SHT_GROUP): self = .group
        case RawValue(SHT_SYMTAB_SHNDX): self = .symtab_shndx
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .null: RawValue(SHT_NULL)
        case .progbits: RawValue(SHT_PROGBITS)
        case .symtab: RawValue(SHT_SYMTAB)
        case .strtab: RawValue(SHT_STRTAB)
        case .rela: RawValue(SHT_RELA)
        case .hash: RawValue(SHT_HASH)
        case .dynamic: RawValue(SHT_DYNAMIC)
        case .note: RawValue(SHT_NOTE)
        case .nobits: RawValue(SHT_NOBITS)
        case .rel: RawValue(SHT_REL)
        case .shlib: RawValue(SHT_SHLIB)
        case .dynsym: RawValue(SHT_DYNSYM)
        case .init_array: RawValue(SHT_INIT_ARRAY)
        case .fini_array: RawValue(SHT_FINI_ARRAY)
        case .preinit_array: RawValue(SHT_PREINIT_ARRAY)
        case .group: RawValue(SHT_GROUP)
        case .symtab_shndx: RawValue(SHT_SYMTAB_SHNDX)
        }
    }
}

extension SectionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: "SHT_NULL"
        case .progbits: "SHT_PROGBITS"
        case .symtab: "SHT_SYMTAB"
        case .strtab: "SHT_STRTAB"
        case .rela: "SHT_RELA"
        case .hash: "SHT_HASH"
        case .dynamic: "SHT_DYNAMIC"
        case .note: "SHT_NOTE"
        case .nobits: "SHT_NOBITS"
        case .rel: "SHT_REL"
        case .shlib: "SHT_SHLIB"
        case .dynsym: "SHT_DYNSYM"
        case .init_array: "SHT_INIT_ARRAY"
        case .fini_array: "SHT_FINI_ARRAY"
        case .preinit_array: "SHT_PREINIT_ARRAY"
        case .group: "SHT_GROUP"
        case .symtab_shndx: "SHT_SYMTAB_SHNDX"
        }
    }
}
