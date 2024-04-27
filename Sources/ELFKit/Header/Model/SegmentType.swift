//
//  SegmentType.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SegmentType: CaseIterable {
    /// PT_NULL
    case null
    /// PT_LOAD
    case load
    /// PT_DYNAMIC
    case dynamic
    /// PT_INTERP
    case interp
    /// PT_NOTE
    case note
    /// PT_SHLIB
    case shlib
    /// PT_PHDR
    case phdr
    /// PT_TLS
    case tls
    /// PT_LOOS
    case loos
    /// PT_HIOS
    case hios
    /// PT_LOPROC
    case loproc
    /// PT_HIPROC
    case hiproc
    /// PT_GNU_EH_FRAME
    case gnu_eh_frame
    /// PT_GNU_STACK
    case gnu_stack
    /// PT_GNU_RELRO
    case gnu_relro
    /// PT_GNU_PROPERTY
    case gnu_property
    /// PT_AARCH64_MEMTAG_MTE
    case aarch64_memtag_mte
}

extension SegmentType: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PT_NULL): self = .null
        case RawValue(PT_LOAD): self = .load
        case RawValue(PT_DYNAMIC): self = .dynamic
        case RawValue(PT_INTERP): self = .interp
        case RawValue(PT_NOTE): self = .note
        case RawValue(PT_SHLIB): self = .shlib
        case RawValue(PT_PHDR): self = .phdr
        case RawValue(PT_TLS): self = .tls
        case RawValue(PT_LOOS): self = .loos
        case RawValue(PT_HIOS): self = .hios
        case RawValue(PT_LOPROC): self = .loproc
        case RawValue(PT_HIPROC): self = .hiproc
        case RawValue(PT_GNU_EH_FRAME): self = .gnu_eh_frame
        case RawValue(PT_GNU_STACK): self = .gnu_stack
        case RawValue(PT_GNU_RELRO): self = .gnu_relro
        case RawValue(PT_GNU_PROPERTY): self = .gnu_property
        case RawValue(PT_AARCH64_MEMTAG_MTE): self = .aarch64_memtag_mte
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .null: RawValue(PT_NULL)
        case .load: RawValue(PT_LOAD)
        case .dynamic: RawValue(PT_DYNAMIC)
        case .interp: RawValue(PT_INTERP)
        case .note: RawValue(PT_NOTE)
        case .shlib: RawValue(PT_SHLIB)
        case .phdr: RawValue(PT_PHDR)
        case .tls: RawValue(PT_TLS)
        case .loos: RawValue(PT_LOOS)
        case .hios: RawValue(PT_HIOS)
        case .loproc: RawValue(PT_LOPROC)
        case .hiproc: RawValue(PT_HIPROC)
        case .gnu_eh_frame: RawValue(PT_GNU_EH_FRAME)
        case .gnu_stack: RawValue(PT_GNU_STACK)
        case .gnu_relro: RawValue(PT_GNU_RELRO)
        case .gnu_property: RawValue(PT_GNU_PROPERTY)
        case .aarch64_memtag_mte: RawValue(PT_AARCH64_MEMTAG_MTE)
        }
    }
}

extension SegmentType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: "PT_NULL"
        case .load: "PT_LOAD"
        case .dynamic: "PT_DYNAMIC"
        case .interp: "PT_INTERP"
        case .note: "PT_NOTE"
        case .shlib: "PT_SHLIB"
        case .phdr: "PT_PHDR"
        case .tls: "PT_TLS"
        case .loos: "PT_LOOS"
        case .hios: "PT_HIOS"
        case .loproc: "PT_LOPROC"
        case .hiproc: "PT_HIPROC"
        case .gnu_eh_frame: "PT_GNU_EH_FRAME"
        case .gnu_stack: "PT_GNU_STACK"
        case .gnu_relro: "PT_GNU_RELRO"
        case .gnu_property: "PT_GNU_PROPERTY"
        case .aarch64_memtag_mte: "PT_AARCH64_MEMTAG_MTE"
        }
    }
}
