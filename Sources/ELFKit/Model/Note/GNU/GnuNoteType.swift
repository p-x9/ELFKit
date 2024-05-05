//
//  GnuNoteType.swift
//
//
//  Created by p-x9 on 2024/05/05
//  
//

import Foundation

public enum GnuNoteType: CaseIterable {
    /// NT_GNU_ABI_TAG
    case abi_tag
    /// NT_GNU_HWCAP
    case hwcap
    /// NT_GNU_BUILD_ID
    case build_id
    /// NT_GNU_GOLD_VERSION
    case gold_version
    /// NT_GNU_PROPERTY_TYPE_0
    case property_type_0
}

extension GnuNoteType: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(NT_GNU_ABI_TAG): self = .abi_tag
        case RawValue(NT_GNU_HWCAP): self = .hwcap
        case RawValue(NT_GNU_BUILD_ID): self = .build_id
        case RawValue(NT_GNU_GOLD_VERSION): self = .gold_version
        case RawValue(NT_GNU_PROPERTY_TYPE_0): self = .property_type_0
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .abi_tag: RawValue(NT_GNU_ABI_TAG)
        case .hwcap: RawValue(NT_GNU_HWCAP)
        case .build_id: RawValue(NT_GNU_BUILD_ID)
        case .gold_version: RawValue(NT_GNU_GOLD_VERSION)
        case .property_type_0: RawValue(NT_GNU_PROPERTY_TYPE_0)
        }
    }
}

extension GnuNoteType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .abi_tag: "NT_GNU_ABI_TAG"
        case .hwcap: "NT_GNU_HWCAP"
        case .build_id: "NT_GNU_BUILD_ID"
        case .gold_version: "NT_GNU_GOLD_VERSION"
        case .property_type_0: "NT_GNU_PROPERTY_TYPE_0"
        }
    }
}
