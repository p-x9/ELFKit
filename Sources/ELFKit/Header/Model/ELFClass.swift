//
//  ELFClass.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public enum ELFClass {
    /// ELFCLASSNONE
    case none
    /// ELFCLASS32
    case _32
    /// ELFCLASS64
    case _64
}

extension ELFClass: RawRepresentable {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(ELFCLASSNONE): self = .none
        case RawValue(ELFCLASS32): self = ._32
        case RawValue(ELFCLASS64): self = ._64
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .none: RawValue(ELFCLASSNONE)
        case ._32: RawValue(ELFCLASS32)
        case ._64: RawValue(ELFCLASS64)
        }
    }
}

extension ELFClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ELFCLASSNONE"
        case ._32: "ELFCLASS32"
        case ._64: "ELFCLASS64"
        }
    }
}
