//
//  SymbolInfoSpecialBound.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public enum SymbolInfoSpecialBound: CaseIterable {
    /// SYMINFO_BT_SELF
    case `self`
    /// SYMINFO_BT_PARENT
    case parent
    /// SYMINFO_BT_NONE
    case none
    /// SYMINFO_BT_EXTERN
    case extern
}

extension SymbolInfoSpecialBound: RawRepresentable {
    public typealias RawValue = UInt16

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SYMINFO_BT_SELF): self = .`self`
        case RawValue(SYMINFO_BT_PARENT): self = .parent
        case RawValue(SYMINFO_BT_NONE): self = .none
        case RawValue(SYMINFO_BT_EXTERN): self = .extern
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .`self`: RawValue(SYMINFO_BT_SELF)
        case .parent: RawValue(SYMINFO_BT_PARENT)
        case .none: RawValue(SYMINFO_BT_NONE)
        case .extern: RawValue(SYMINFO_BT_EXTERN)
        }
    }
}

extension SymbolInfoSpecialBound: CustomStringConvertible {
    public var description: String {
        switch self {
        case .`self`: "SYMINFO_BT_SELF"
        case .parent: "SYMINFO_BT_PARENT"
        case .none: "SYMINFO_BT_NONE"
        case .extern: "SYMINFO_BT_EXTERN"
        }
    }
}
