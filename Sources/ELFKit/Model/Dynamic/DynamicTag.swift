//
//  DynamicTag.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public enum DynamicTag: CaseIterable {
    /// DT_NULL
    case null
    /// DT_NEEDED
    case needed
    /// DT_PLTRELSZ
    case pltrelsz
    /// DT_PLTGOT
    case pltgot
    /// DT_HASH
    case hash
    /// DT_STRTAB
    case strtab
    /// DT_SYMTAB
    case symtab
    /// DT_RELA
    case rela
    /// DT_RELASZ
    case relasz
    /// DT_RELAENT
    case relaent
    /// DT_STRSZ
    case strsz
    /// DT_SYMENT
    case syment
    /// DT_INIT
    case `init`
    /// DT_FINI
    case fini
    /// DT_SONAME
    case soname
    /// DT_RPATH
    case rpath
    /// DT_SYMBOLIC
    case symbolic
    /// DT_REL
    case rel
    /// DT_RELSZ
    case relsz
    /// DT_RELENT
    case relent
    /// DT_PLTREL
    case pltrel
    /// DT_DEBUG
    case debug
    /// DT_TEXTREL
    case textrel
    /// DT_JMPREL
    case jmprel
    /// DT_ENCODING
    case encoding
    /// OLD_DT_LOOS
//    case old_loos
    /// DT_LOOS
    case loos
    /// DT_HIOS
    case hios
    /// DT_VALRNGLO
    case valrnglo
    /// DT_VALRNGHI
    case valrnghi
    /// DT_ADDRRNGLO
    case addrrnglo
    /// DT_ADDRRNGHI
    case addrrnghi
    /// DT_VERSYM
    case versym
    /// DT_RELACOUNT
    case relacount
    /// DT_RELCOUNT
    case relcount
    /// DT_FLAGS_1
    case flags_1
    /// DT_VERDEF
    case verdef
    /// DT_VERDEFNUM
    case verdefnum
    /// DT_VERNEED
    case verneed
    /// DT_VERNEEDNUM
    case verneednum
    /// OLD_DT_HIOS
//    case old_hios
    /// DT_LOPROC
    case loproc
    /// DT_HIPROC
    case hiproc
}

extension DynamicTag: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DT_NULL): self = .null
        case RawValue(DT_NEEDED): self = .needed
        case RawValue(DT_PLTRELSZ): self = .pltrelsz
        case RawValue(DT_PLTGOT): self = .pltgot
        case RawValue(DT_HASH): self = .hash
        case RawValue(DT_STRTAB): self = .strtab
        case RawValue(DT_SYMTAB): self = .symtab
        case RawValue(DT_RELA): self = .rela
        case RawValue(DT_RELASZ): self = .relasz
        case RawValue(DT_RELAENT): self = .relaent
        case RawValue(DT_STRSZ): self = .strsz
        case RawValue(DT_SYMENT): self = .syment
        case RawValue(DT_INIT): self = .`init`
        case RawValue(DT_FINI): self = .fini
        case RawValue(DT_SONAME): self = .soname
        case RawValue(DT_RPATH): self = .rpath
        case RawValue(DT_SYMBOLIC): self = .symbolic
        case RawValue(DT_REL): self = .rel
        case RawValue(DT_RELSZ): self = .relsz
        case RawValue(DT_RELENT): self = .relent
        case RawValue(DT_PLTREL): self = .pltrel
        case RawValue(DT_DEBUG): self = .debug
        case RawValue(DT_TEXTREL): self = .textrel
        case RawValue(DT_JMPREL): self = .jmprel
        case RawValue(DT_ENCODING): self = .encoding
//        case RawValue(OLD_DT_LOOS): self = .old_loos
        case RawValue(DT_LOOS): self = .loos
        case RawValue(DT_HIOS): self = .hios
        case RawValue(DT_VALRNGLO): self = .valrnglo
        case RawValue(DT_VALRNGHI): self = .valrnghi
        case RawValue(DT_ADDRRNGLO): self = .addrrnglo
        case RawValue(DT_ADDRRNGHI): self = .addrrnghi
        case RawValue(DT_VERSYM): self = .versym
        case RawValue(DT_RELACOUNT): self = .relacount
        case RawValue(DT_RELCOUNT): self = .relcount
        case RawValue(DT_FLAGS_1): self = .flags_1
        case RawValue(DT_VERDEF): self = .verdef
        case RawValue(DT_VERDEFNUM): self = .verdefnum
        case RawValue(DT_VERNEED): self = .verneed
        case RawValue(DT_VERNEEDNUM): self = .verneednum
//        case RawValue(OLD_DT_HIOS): self = .old_hios
        case RawValue(DT_LOPROC): self = .loproc
        case RawValue(DT_HIPROC): self = .hiproc
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .null: RawValue(DT_NULL)
        case .needed: RawValue(DT_NEEDED)
        case .pltrelsz: RawValue(DT_PLTRELSZ)
        case .pltgot: RawValue(DT_PLTGOT)
        case .hash: RawValue(DT_HASH)
        case .strtab: RawValue(DT_STRTAB)
        case .symtab: RawValue(DT_SYMTAB)
        case .rela: RawValue(DT_RELA)
        case .relasz: RawValue(DT_RELASZ)
        case .relaent: RawValue(DT_RELAENT)
        case .strsz: RawValue(DT_STRSZ)
        case .syment: RawValue(DT_SYMENT)
        case .`init`: RawValue(DT_INIT)
        case .fini: RawValue(DT_FINI)
        case .soname: RawValue(DT_SONAME)
        case .rpath: RawValue(DT_RPATH)
        case .symbolic: RawValue(DT_SYMBOLIC)
        case .rel: RawValue(DT_REL)
        case .relsz: RawValue(DT_RELSZ)
        case .relent: RawValue(DT_RELENT)
        case .pltrel: RawValue(DT_PLTREL)
        case .debug: RawValue(DT_DEBUG)
        case .textrel: RawValue(DT_TEXTREL)
        case .jmprel: RawValue(DT_JMPREL)
        case .encoding: RawValue(DT_ENCODING)
//        case .old_loos: RawValue(OLD_DT_LOOS)
        case .loos: RawValue(DT_LOOS)
        case .hios: RawValue(DT_HIOS)
        case .valrnglo: RawValue(DT_VALRNGLO)
        case .valrnghi: RawValue(DT_VALRNGHI)
        case .addrrnglo: RawValue(DT_ADDRRNGLO)
        case .addrrnghi: RawValue(DT_ADDRRNGHI)
        case .versym: RawValue(DT_VERSYM)
        case .relacount: RawValue(DT_RELACOUNT)
        case .relcount: RawValue(DT_RELCOUNT)
        case .flags_1: RawValue(DT_FLAGS_1)
        case .verdef: RawValue(DT_VERDEF)
        case .verdefnum: RawValue(DT_VERDEFNUM)
        case .verneed: RawValue(DT_VERNEED)
        case .verneednum: RawValue(DT_VERNEEDNUM)
//        case .old_hios: RawValue(OLD_DT_HIOS)
        case .loproc: RawValue(DT_LOPROC)
        case .hiproc: RawValue(DT_HIPROC)
        }
    }
}


extension DynamicTag: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: "DT_NULL"
        case .needed: "DT_NEEDED"
        case .pltrelsz: "DT_PLTRELSZ"
        case .pltgot: "DT_PLTGOT"
        case .hash: "DT_HASH"
        case .strtab: "DT_STRTAB"
        case .symtab: "DT_SYMTAB"
        case .rela: "DT_RELA"
        case .relasz: "DT_RELASZ"
        case .relaent: "DT_RELAENT"
        case .strsz: "DT_STRSZ"
        case .syment: "DT_SYMENT"
        case .`init`: "DT_INIT"
        case .fini: "DT_FINI"
        case .soname: "DT_SONAME"
        case .rpath: "DT_RPATH"
        case .symbolic: "DT_SYMBOLIC"
        case .rel: "DT_REL"
        case .relsz: "DT_RELSZ"
        case .relent: "DT_RELENT"
        case .pltrel: "DT_PLTREL"
        case .debug: "DT_DEBUG"
        case .textrel: "DT_TEXTREL"
        case .jmprel: "DT_JMPREL"
        case .encoding: "DT_ENCODING"
//        case .old_loos: "OLD_DT_LOOS"
        case .loos: "DT_LOOS"
        case .hios: "DT_HIOS"
        case .valrnglo: "DT_VALRNGLO"
        case .valrnghi: "DT_VALRNGHI"
        case .addrrnglo: "DT_ADDRRNGLO"
        case .addrrnghi: "DT_ADDRRNGHI"
        case .versym: "DT_VERSYM"
        case .relacount: "DT_RELACOUNT"
        case .relcount: "DT_RELCOUNT"
        case .flags_1: "DT_FLAGS_1"
        case .verdef: "DT_VERDEF"
        case .verdefnum: "DT_VERDEFNUM"
        case .verneed: "DT_VERNEED"
        case .verneednum: "DT_VERNEEDNUM"
//        case .old_hios: "OLD_DT_HIOS"
        case .loproc: "DT_LOPROC"
        case .hiproc: "DT_HIPROC"
        }
    }
}
