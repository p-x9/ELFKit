//
//  ProgramFlags.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public struct ProgramFlags: BitFlags {
    public typealias RawValue = UInt64

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension ProgramFlags {
    public static let r = ProgramFlags(
        rawValue: Bit.r.rawValue
    )
    public static let w = ProgramFlags(
        rawValue: Bit.w.rawValue
    )
    public static let x = ProgramFlags(
        rawValue: Bit.x.rawValue
    )
}


extension ProgramFlags {
    public enum Bit: CaseIterable {
        /// PF_R
        case r
        /// PF_W
        case w
        /// PF_X
        case x
    }
}

extension ProgramFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PF_R): self = .r
        case RawValue(PF_W): self = .w
        case RawValue(PF_X): self = .x
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .r: RawValue(PF_R)
        case .w: RawValue(PF_W)
        case .x: RawValue(PF_X)
        }
    }
}

extension ProgramFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .r: "PF_R"
        case .w: "PF_W"
        case .x: "PF_X"
        }
    }
}
