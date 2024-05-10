//
//  VersionFlags.swift
//
//
//  Created by p-x9 on 2024/04/30
//
//

import Foundation
import ELFKitC

public struct VersionFlags: BitFlags {
    public typealias RawValue = UInt16

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension VersionFlags {
    /// VER_FLG_BASE
    public static let base = VersionFlags(
        rawValue: Bit.base.rawValue
    )
    /// VER_FLG_WEAK
    public static let weak = VersionFlags(
        rawValue: Bit.weak.rawValue
    )
    /// VER_FLG_INFO
    public static let info = VersionFlags(
        rawValue: Bit.info.rawValue
    )
}

extension VersionFlags {
    public enum Bit: UInt16, CaseIterable {
        /// VER_FLG_BASE
        case base = 1
        /// VER_FLG_WEAK
        case weak = 2
        /// VER_FLG_INFO
        case info = 4
    }
}

extension VersionFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .base: "VER_FLG_BASE"
        case .weak: "VER_FLG_WEAK"
        case .info: "VER_FLG_INFO"
        }
    }
}
