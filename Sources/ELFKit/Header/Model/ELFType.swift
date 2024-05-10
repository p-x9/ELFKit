//
//  ELFType.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public enum ELFType: UInt16, CaseIterable {
    /// ET_NONE
    case none = 0
    /// ET_REL
    case rel = 1
    /// ET_EXEC
    case exec = 2
    /// ET_DYN
    case dyn = 3
    /// ET_CORE
    case core = 4
}

extension ELFType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ET_NONE"
        case .rel: "ET_REL"
        case .exec: "ET_EXEC"
        case .dyn: "ET_DYN"
        case .core: "ET_CORE"
        }
    }
}
