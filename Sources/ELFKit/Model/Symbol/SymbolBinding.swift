//
//  SymbolBinding.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SymbolBinding: CaseIterable {
    /// STB_LOCAL
    case local
    /// STB_GLOBAL
    case global
    /// STB_WEAK
    case weak
    /// STB_LOPROC
    case loproc
    /// STB_HIPROC
    case hiproc
}

extension SymbolBinding: RawRepresentable {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(STB_LOCAL): self = .local
        case RawValue(STB_GLOBAL): self = .global
        case RawValue(STB_WEAK): self = .weak
        case RawValue(13): self = .loproc
        case RawValue(15): self = .hiproc
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .local: RawValue(STB_LOCAL)
        case .global: RawValue(STB_GLOBAL)
        case .weak: RawValue(STB_WEAK)
        case .loproc: RawValue(13)
        case .hiproc: RawValue(15)
        }
    }
}

extension SymbolBinding: CustomStringConvertible {
    public var description: String {
        switch self {
        case .local: "STB_LOCAL"
        case .global: "STB_GLOBAL"
        case .weak: "STB_WEAK"
        case .loproc: "STB_LOPROC"
        case .hiproc: "STB_HIPROC"
        }
    }
}
