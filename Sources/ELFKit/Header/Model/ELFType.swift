//
//  ELFType.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public enum ELFType {
    /// ET_NONE
    case none
    /// ET_REL
    case rel
    /// ET_EXEC
    case exec
    /// ET_DYN
    case dyn
    /// ET_CORE
    case core
    /// ET_CORE
    case loproc
    /// ET_HIPROC
    case hiproc
}

extension ELFType: RawRepresentable {
    public typealias RawValue = UInt16

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(ET_NONE): self = .none
        case RawValue(ET_REL): self = .rel
        case RawValue(ET_EXEC): self = .exec
        case RawValue(ET_DYN): self = .dyn
        case RawValue(ET_CORE): self = .core
        case RawValue(ET_LOPROC): self = .loproc
        case RawValue(ET_HIPROC): self = .hiproc
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .none: RawValue(ET_NONE)
        case .rel: RawValue(ET_REL)
        case .exec: RawValue(ET_EXEC)
        case .dyn: RawValue(ET_DYN)
        case .core: RawValue(ET_CORE)
        case .loproc: RawValue(ET_LOPROC)
        case .hiproc: RawValue(ET_HIPROC)
        }
    }
}

extension ELFType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ET_NONE"
        case .rel: "ET_REL"
        case .exec: "ET_EXEC"
        case .dyn: "ET_DYN"
        case .core: "ET_CORE"
        case .loproc: "ET_LOPROC"
        case .hiproc: "ET_HIPROC"
        }
    }
}
