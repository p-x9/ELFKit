//
//  SymbolVisibility.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public enum SymbolVisibility: UInt8, CaseIterable {
    /// STV_DEFAULT
    case `default` = 0
    /// STV_INTERNAL
    case `internal` = 1
    /// STV_HIDDEN
    case hidden = 2
    /// STV_PROTECTED
    case protected = 3
    /// STV_EXPORTED
    case exported = 4
    /// STV_SINGLETON
    case singleton = 5
    /// STV_ELIMINATE
    case eliminate = 6
}

extension SymbolVisibility: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default: "STV_DEFAULT"
        case .internal: "STV_INTERNAL"
        case .hidden: "STV_HIDDEN"
        case .protected: "STV_PROTECTED"
        case .exported: "STV_EXPORTED"
        case .singleton: "STV_SINGLETON"
        case .eliminate: "STV_ELIMINATE"
        }
    }
}
