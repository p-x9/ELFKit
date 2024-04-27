//
//  SymbolType.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SymbolType: CaseIterable {
    /// STT_NOTYPE
    case notype
    /// STT_OBJECT
    case object
    /// STT_FUNC
    case `func`
    /// STT_SECTION
    case section
    /// STT_FILE
    case file
    /// STT_COMMON
    case common
    /// STT_TLS
    case tls
    /// STT_LOPROC
    case loproc
    /// STT_HIPROC
    case hiproc
}

extension SymbolType: RawRepresentable {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(STT_NOTYPE): self = .notype
        case RawValue(STT_OBJECT): self = .object
        case RawValue(STT_FUNC): self = .func
        case RawValue(STT_SECTION): self = .section
        case RawValue(STT_FILE): self = .file
        case RawValue(STT_COMMON): self = .common
        case RawValue(STT_TLS): self = .tls
        case RawValue(13): self = .loproc
        case RawValue(15): self = .hiproc
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .notype: RawValue(STT_NOTYPE)
        case .object: RawValue(STT_OBJECT)
        case .func: RawValue(STT_FUNC)
        case .section: RawValue(STT_SECTION)
        case .file: RawValue(STT_FILE)
        case .common: RawValue(STT_COMMON)
        case .tls: RawValue(STT_TLS)
        case .loproc: RawValue(13)
        case .hiproc: RawValue(15)
        }
    }
}

extension SymbolType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notype: "STT_NOTYPE"
        case .object: "STT_OBJECT"
        case .func: "STT_FUNC"
        case .section: "STT_SECTION"
        case .file: "STT_FILE"
        case .common: "STT_COMMON"
        case .tls: "STT_TLS"
        case .loproc: "STT_LOPROC"
        case .hiproc: "STT_HIPROC"
        }
    }
}
