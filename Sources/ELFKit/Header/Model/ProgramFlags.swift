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
    public typealias RawValue = UInt32

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension ProgramFlags {
    public var isOSSpecific: Bool {
        let PF_MASKOS = 0x0ff00000
        return (rawValue & numericCast(PF_MASKOS)) > 0
    }

    public var isProcessorSpecific: Bool {
        let PF_MASKPROC = 0xf0000000
        return (rawValue & numericCast(PF_MASKPROC)) > 0
    }
}

extension ProgramFlags {
    /// PF_X
    public static let x = ProgramFlags(
        rawValue: Bit.x.rawValue
    )
    /// PF_W
    public static let w = ProgramFlags(
        rawValue: Bit.w.rawValue
    )
    /// PF_R
    public static let r = ProgramFlags(
        rawValue: Bit.r.rawValue
    )
}

extension ProgramFlags {
    public enum Bit: UInt32, CaseIterable {
        /// PF_X
        case x = 1
        /// PF_W
        case w = 2
        /// PF_R
        case r = 4
    }
}

extension ProgramFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .x: "PF_X"
        case .w: "PF_W"
        case .r: "PF_R"
        }
    }
}
