//
//  GnuNoteContent.swift
//
//
//  Created by p-x9 on 2024/05/05
//  
//

import Foundation

public enum GnuNoteContent {
    /// NT_GNU_ABI_TAG
    case abi_tag(GnuABITag)
    /// NT_GNU_HWCAP
    case hwcap(GnuHardwareCapabilities)
    /// NT_GNU_BUILD_ID
    case build_id(String)
    /// NT_GNU_GOLD_VERSION
    case gold_version(String)
    /// NT_GNU_PROPERTY_TYPE_0
    case property_type_0(Data)
}

extension GnuNoteContent {
    public var type: GnuNoteType {
        switch self {
        case .abi_tag: .abi_tag
        case .hwcap: .hwcap
        case .build_id: .build_id
        case .gold_version: .gold_version
        case .property_type_0: .property_type_0
        }
     }
}
