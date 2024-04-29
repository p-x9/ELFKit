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
    /// DT_BIND_NOW
    case bind_now
    /// DT_INIT_ARRAY
    case init_array
    /// DT_FINI_ARRAY
    case fini_array
    /// DT_INIT_ARRAYSZ
    case init_arraysz
    /// DT_FINI_ARRAYSZ
    case fini_arraysz
    /// DT_RUNPATH
    case runpath
    /// DT_FLAGS
    case flags
//    /// DT_ENCODING
//    case encoding
    /// DT_PREINIT_ARRAY
    case preinit_array
    /// DT_PREINIT_ARRAYSZ
    case preinit_arraysz
    /// DT_MAXPOSTAGS
    case maxpostags
    /// DT_RELRSZ
    case relrsz
    /// DT_RELR
    case relr
    /// DT_RELRENT
    case relrent
//    /// DT_VALRNGLO
//    case valrnglo
    /// DT_GNU_PRELINKED
    case gnu_prelinked
    /// DT_GNU_CONFLICTSZ
    case gnu_conflictsz
    /// DT_GNU_LIBLISTSZ
    case gnu_liblistsz
    /// DT_CHECKSUM
    case checksum
    /// DT_PLTPADSZ
    case pltpadsz
    /// DT_MOVEENT
    case moveent
    /// DT_MOVESZ
    case movesz
    /// DT_FEATURE
    case feature
    /// DT_FEATURE_1
    case feature_1
    /// DT_POSFLAG_1
    case posflag_1
    /// DT_SYMINSZ
    case syminsz
    /// DT_SYMINENT
    case syminent
//    /// DT_VALRNGHI
//    case valrnghi
//    /// DT_ADDRRNGLO
//    case addrrnglo
    /// DT_GNU_HASH
    case gnu_hash
    /// DT_TLSDESC_PLT
    case tlsdesc_plt
    /// DT_TLSDESC_GOT
    case tlsdesc_got
    /// DT_GNU_CONFLICT
    case gnu_conflict
    /// DT_GNU_LIBLIST
    case gnu_liblist
    /// DT_CONFIG
    case config
    /// DT_DEPAUDIT
    case depaudit
    /// DT_AUDIT
    case audit
    /// DT_PLTPAD
    case pltpad
    /// DT_MOVETAB
    case movetab
    /// DT_SYMINFO
    case syminfo
//    /// DT_ADDRRNGHI
//    case addrrnghi
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
}

extension DynamicTag: RawRepresentable {
    public typealias RawValue = UInt64

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
        case RawValue(DT_BIND_NOW): self = .bind_now
        case RawValue(DT_INIT_ARRAY): self = .init_array
        case RawValue(DT_FINI_ARRAY): self = .fini_array
        case RawValue(DT_INIT_ARRAYSZ): self = .init_arraysz
        case RawValue(DT_FINI_ARRAYSZ): self = .fini_arraysz
        case RawValue(DT_RUNPATH): self = .runpath
        case RawValue(DT_FLAGS): self = .flags
//        case RawValue(DT_ENCODING): self = .encoding
        case RawValue(DT_PREINIT_ARRAY): self = .preinit_array
        case RawValue(DT_PREINIT_ARRAYSZ): self = .preinit_arraysz
        case RawValue(DT_MAXPOSTAGS): self = .maxpostags
        case RawValue(DT_RELRSZ): self = .relrsz
        case RawValue(DT_RELR): self = .relr
        case RawValue(DT_RELRENT): self = .relrent
//        case RawValue(DT_VALRNGLO): self = .valrnglo
        case RawValue(DT_GNU_PRELINKED): self = .gnu_prelinked
        case RawValue(DT_GNU_CONFLICTSZ): self = .gnu_conflictsz
        case RawValue(DT_GNU_LIBLISTSZ): self = .gnu_liblistsz
        case RawValue(DT_CHECKSUM): self = .checksum
        case RawValue(DT_PLTPADSZ): self = .pltpadsz
        case RawValue(DT_MOVEENT): self = .moveent
        case RawValue(DT_MOVESZ): self = .movesz
        case RawValue(DT_FEATURE): self = .feature
        case RawValue(DT_FEATURE_1): self = .feature_1
        case RawValue(DT_POSFLAG_1): self = .posflag_1
        case RawValue(DT_SYMINSZ): self = .syminsz
        case RawValue(DT_SYMINENT): self = .syminent
//        case RawValue(DT_VALRNGHI): self = .valrnghi
//        case RawValue(DT_ADDRRNGLO): self = .addrrnglo
        case RawValue(DT_GNU_HASH): self = .gnu_hash
        case RawValue(DT_TLSDESC_PLT): self = .tlsdesc_plt
        case RawValue(DT_TLSDESC_GOT): self = .tlsdesc_got
        case RawValue(DT_GNU_CONFLICT): self = .gnu_conflict
        case RawValue(DT_GNU_LIBLIST): self = .gnu_liblist
        case RawValue(DT_CONFIG): self = .config
        case RawValue(DT_DEPAUDIT): self = .depaudit
        case RawValue(DT_AUDIT): self = .audit
        case RawValue(DT_PLTPAD): self = .pltpad
        case RawValue(DT_MOVETAB): self = .movetab
        case RawValue(DT_SYMINFO): self = .syminfo
//        case RawValue(DT_ADDRRNGHI): self = .addrrnghi
        case RawValue(DT_VERSYM): self = .versym
        case RawValue(DT_RELACOUNT): self = .relacount
        case RawValue(DT_RELCOUNT): self = .relcount
        case RawValue(DT_FLAGS_1): self = .flags_1
        case RawValue(DT_VERDEF): self = .verdef
        case RawValue(DT_VERDEFNUM): self = .verdefnum
        case RawValue(DT_VERNEED): self = .verneed
        case RawValue(DT_VERNEEDNUM): self = .verneednum
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
        case .bind_now: RawValue(DT_BIND_NOW)
        case .init_array: RawValue(DT_INIT_ARRAY)
        case .fini_array: RawValue(DT_FINI_ARRAY)
        case .init_arraysz: RawValue(DT_INIT_ARRAYSZ)
        case .fini_arraysz: RawValue(DT_FINI_ARRAYSZ)
        case .runpath: RawValue(DT_RUNPATH)
        case .flags: RawValue(DT_FLAGS)
//        case .encoding: RawValue(DT_ENCODING)
        case .preinit_array: RawValue(DT_PREINIT_ARRAY)
        case .preinit_arraysz: RawValue(DT_PREINIT_ARRAYSZ)
        case .maxpostags: RawValue(DT_MAXPOSTAGS)
        case .relrsz: RawValue(DT_RELRSZ)
        case .relr: RawValue(DT_RELR)
        case .relrent: RawValue(DT_RELRENT)
//        case .valrnglo: RawValue(DT_VALRNGLO)
        case .gnu_prelinked: RawValue(DT_GNU_PRELINKED)
        case .gnu_conflictsz: RawValue(DT_GNU_CONFLICTSZ)
        case .gnu_liblistsz: RawValue(DT_GNU_LIBLISTSZ)
        case .checksum: RawValue(DT_CHECKSUM)
        case .pltpadsz: RawValue(DT_PLTPADSZ)
        case .moveent: RawValue(DT_MOVEENT)
        case .movesz: RawValue(DT_MOVESZ)
        case .feature: RawValue(DT_FEATURE)
        case .feature_1: RawValue(DT_FEATURE_1)
        case .posflag_1: RawValue(DT_POSFLAG_1)
        case .syminsz: RawValue(DT_SYMINSZ)
        case .syminent: RawValue(DT_SYMINENT)
//        case .valrnghi: RawValue(DT_VALRNGHI)
//        case .addrrnglo: RawValue(DT_ADDRRNGLO)
        case .gnu_hash: RawValue(DT_GNU_HASH)
        case .tlsdesc_plt: RawValue(DT_TLSDESC_PLT)
        case .tlsdesc_got: RawValue(DT_TLSDESC_GOT)
        case .gnu_conflict: RawValue(DT_GNU_CONFLICT)
        case .gnu_liblist: RawValue(DT_GNU_LIBLIST)
        case .config: RawValue(DT_CONFIG)
        case .depaudit: RawValue(DT_DEPAUDIT)
        case .audit: RawValue(DT_AUDIT)
        case .pltpad: RawValue(DT_PLTPAD)
        case .movetab: RawValue(DT_MOVETAB)
        case .syminfo: RawValue(DT_SYMINFO)
//        case .addrrnghi: RawValue(DT_ADDRRNGHI)
        case .versym: RawValue(DT_VERSYM)
        case .relacount: RawValue(DT_RELACOUNT)
        case .relcount: RawValue(DT_RELCOUNT)
        case .flags_1: RawValue(DT_FLAGS_1)
        case .verdef: RawValue(DT_VERDEF)
        case .verdefnum: RawValue(DT_VERDEFNUM)
        case .verneed: RawValue(DT_VERNEED)
        case .verneednum: RawValue(DT_VERNEEDNUM)
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
        case .bind_now: "DT_BIND_NOW"
        case .init_array: "DT_INIT_ARRAY"
        case .fini_array: "DT_FINI_ARRAY"
        case .init_arraysz: "DT_INIT_ARRAYSZ"
        case .fini_arraysz: "DT_FINI_ARRAYSZ"
        case .runpath: "DT_RUNPATH"
        case .flags: "DT_FLAGS"
//        case .encoding: "DT_ENCODING"
        case .preinit_array: "DT_PREINIT_ARRAY"
        case .preinit_arraysz: "DT_PREINIT_ARRAYSZ"
        case .maxpostags: "DT_MAXPOSTAGS"
        case .relrsz: "DT_RELRSZ"
        case .relr: "DT_RELR"
        case .relrent: "DT_RELRENT"
//        case .valrnglo: "DT_VALRNGLO"
        case .gnu_prelinked: "DT_GNU_PRELINKED"
        case .gnu_conflictsz: "DT_GNU_CONFLICTSZ"
        case .gnu_liblistsz: "DT_GNU_LIBLISTSZ"
        case .checksum: "DT_CHECKSUM"
        case .pltpadsz: "DT_PLTPADSZ"
        case .moveent: "DT_MOVEENT"
        case .movesz: "DT_MOVESZ"
        case .feature: "DT_FEATURE"
        case .feature_1: "DT_FEATURE_1"
        case .posflag_1: "DT_POSFLAG_1"
        case .syminsz: "DT_SYMINSZ"
        case .syminent: "DT_SYMINENT"
//        case .valrnghi: "DT_VALRNGHI"
//        case .addrrnglo: "DT_ADDRRNGLO"
        case .gnu_hash: "DT_GNU_HASH"
        case .tlsdesc_plt: "DT_TLSDESC_PLT"
        case .tlsdesc_got: "DT_TLSDESC_GOT"
        case .gnu_conflict: "DT_GNU_CONFLICT"
        case .gnu_liblist: "DT_GNU_LIBLIST"
        case .config: "DT_CONFIG"
        case .depaudit: "DT_DEPAUDIT"
        case .audit: "DT_AUDIT"
        case .pltpad: "DT_PLTPAD"
        case .movetab: "DT_MOVETAB"
        case .syminfo: "DT_SYMINFO"
//        case .addrrnghi: "DT_ADDRRNGHI"
        case .versym: "DT_VERSYM"
        case .relacount: "DT_RELACOUNT"
        case .relcount: "DT_RELCOUNT"
        case .flags_1: "DT_FLAGS_1"
        case .verdef: "DT_VERDEF"
        case .verdefnum: "DT_VERDEFNUM"
        case .verneed: "DT_VERNEED"
        case .verneednum: "DT_VERNEEDNUM"
        }
    }
}
