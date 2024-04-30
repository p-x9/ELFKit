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
}

extension VersionFlags {
    public enum Bit: CaseIterable {
        /// VER_FLG_BASE
        case base
        /// VER_FLG_WEAK
        case weak
    }
}

extension VersionFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt16

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(VER_FLG_BASE): self = .base
        case RawValue(VER_FLG_WEAK): self = .weak
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .base: RawValue(VER_FLG_BASE)
        case .weak: RawValue(VER_FLG_WEAK)
        }
    }
}

extension VersionFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .base: "VER_FLG_BASE"
        case .weak: "VER_FLG_WEAK"
        }
    }
}
