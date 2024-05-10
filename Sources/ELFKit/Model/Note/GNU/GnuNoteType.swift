//
//  GnuNoteType.swift
//
//
//  Created by p-x9 on 2024/05/05
//  
//

import Foundation

public enum GnuNoteType: UInt32, CaseIterable {
    /// NT_GNU_ABI_TAG
    case abi_tag = 1
    /// NT_GNU_HWCAP
    case hwcap = 2
    /// NT_GNU_BUILD_ID
    case build_id = 3
    /// NT_GNU_GOLD_VERSION
    case gold_version = 4
    /// NT_GNU_PROPERTY_TYPE_0
    case property_type_0 = 5
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
