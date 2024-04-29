//
//  SymbolVisibility.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public enum SymbolVisibility: CaseIterable {
    /// STV_DEFAULT
    case `default`
    /// STV_INTERNAL
    case `internal`
    /// STV_HIDDEN
    case hidden
    /// STV_PROTECTED
    case protected
    /// STV_EXPORTED
    case exported
    /// STV_SINGLETON
    case singleton
    /// STV_ELIMINATE
    case eliminate
}

extension SymbolVisibility: RawRepresentable {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(STV_DEFAULT): self = .default
        case RawValue(STV_INTERNAL): self = .internal
        case RawValue(STV_HIDDEN): self = .hidden
        case RawValue(STV_PROTECTED): self = .protected
        case RawValue(STV_EXPORTED): self = .exported
        case RawValue(STV_SINGLETON): self = .singleton
        case RawValue(STV_ELIMINATE): self = .eliminate
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .default: RawValue(STV_DEFAULT)
        case .internal: RawValue(STV_INTERNAL)
        case .hidden: RawValue(STV_HIDDEN)
        case .protected: RawValue(STV_PROTECTED)
        case .exported: RawValue(STV_EXPORTED)
        case .singleton: RawValue(STV_SINGLETON)
        case .eliminate: RawValue(STV_ELIMINATE)
        }
    }
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
