//
//  SymbolInfoSpecialBound.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public enum SymbolInfoSpecialBound: UInt16, Sendable, CaseIterable {
    /// SYMINFO_BT_SELF
    case `self` = 0xffff
    /// SYMINFO_BT_PARENT
    case parent = 0xfffe
    /// SYMINFO_BT_NONE
    case none = 0xfffd
    /// SYMINFO_BT_EXTERN
    case extern = 0xfffc
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
