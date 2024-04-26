//
//  ELFData.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public enum ELFData {
    /// ELFDATANONE
    case none
    /// ELFDATA2LSB
    case _2LSB
    /// ELFDATA2MSB
    case _2MSB
}

extension ELFData: RawRepresentable {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(ELFDATANONE): self = .none
        case RawValue(ELFDATA2LSB): self = ._2LSB
        case RawValue(ELFDATA2MSB): self = ._2MSB
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .none: RawValue(ELFDATANONE)
        case ._2LSB: RawValue(ELFDATA2LSB)
        case ._2MSB: RawValue(ELFDATA2MSB)
        }
    }
}

extension ELFData: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ELFDATANONE"
        case ._2LSB: "ELFDATA2LSB"
        case ._2MSB: "ELFDATA2MSB"
        }
    }
}
