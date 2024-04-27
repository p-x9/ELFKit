//
//  SpecialSectionIndex.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SpecialSectionIndex: CaseIterable {
    /// SHN_UNDEF
    case undef
    /// SHN_LORESERVE
    case loreserve
    /// SHN_LOPROC
    case loproc
    /// SHN_HIPROC
    case hiproc
    /// SHN_LIVEPATCH
    case livepatch
    /// SHN_ABS
    case abs
    /// SHN_COMMON
    case common
    /// SHN_HIRESERVE
    case hireserve
}

extension SpecialSectionIndex: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHN_UNDEF): self = .undef
        case RawValue(SHN_LORESERVE): self = .loreserve
        case RawValue(SHN_LOPROC): self = .loproc
        case RawValue(SHN_HIPROC): self = .hiproc
        case RawValue(SHN_LIVEPATCH): self = .livepatch
        case RawValue(SHN_ABS): self = .abs
        case RawValue(SHN_COMMON): self = .common
        case RawValue(SHN_HIRESERVE): self = .hireserve
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .undef: RawValue(SHN_UNDEF)
        case .loreserve: RawValue(SHN_LORESERVE)
        case .loproc: RawValue(SHN_LOPROC)
        case .hiproc: RawValue(SHN_HIPROC)
        case .livepatch: RawValue(SHN_LIVEPATCH)
        case .abs: RawValue(SHN_ABS)
        case .common: RawValue(SHN_COMMON)
        case .hireserve: RawValue(SHN_HIRESERVE)
        }
    }
}

extension SpecialSectionIndex: CustomStringConvertible {
    public var description: String {
        switch self {
        case .undef: "SHN_UNDEF"
        case .loreserve: "SHN_LORESERVE"
        case .loproc: "SHN_LOPROC"
        case .hiproc: "SHN_HIPROC"
        case .livepatch: "SHN_LIVEPATCH"
        case .abs: "SHN_ABS"
        case .common: "SHN_COMMON"
        case .hireserve: "SHN_HIRESERVE"
        }
    }
}
