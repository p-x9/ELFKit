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
        }
    }
}
