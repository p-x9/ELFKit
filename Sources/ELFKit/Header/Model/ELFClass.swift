//
//  ELFClass.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public enum ELFClass: UInt8, Sendable {
    /// ELFCLASSNONE
    case none = 0
    /// ELFCLASS32
    case _32 = 1
    /// ELFCLASS64
    case _64 = 2
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
