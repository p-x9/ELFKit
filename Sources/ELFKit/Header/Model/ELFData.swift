//
//  ELFData.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public enum ELFData: UInt8, Sendable {
    /// ELFDATANONE
    case none = 0
    /// ELFDATA2LSB
    case _2lsb = 1
    /// ELFDATA2MSB
    case _2msb = 2
}

extension ELFData: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ELFDATANONE"
        case ._2lsb: "ELFDATA2LSB"
        case ._2msb: "ELFDATA2MSB"
        }
    }
}
