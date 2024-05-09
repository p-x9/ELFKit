//
//  DynamicFlags.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct DynamicFlags: BitFlags {
    public typealias RawValue = UInt32

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension DynamicFlags {
    /// DF_ORIGIN
    public static let origin = DynamicFlags(
        rawValue: Bit.origin.rawValue
    )
    /// DF_SYMBOLIC
    public static let symbolic = DynamicFlags(
        rawValue: Bit.symbolic.rawValue
    )
    /// DF_TEXTREL
    public static let textrel = DynamicFlags(
        rawValue: Bit.textrel.rawValue
    )
    /// DF_BIND_NOW
    public static let bind_now = DynamicFlags(
        rawValue: Bit.bind_now.rawValue
    )
    /// DF_STATIC_TLS
    public static let static_tls = DynamicFlags(
        rawValue: Bit.static_tls.rawValue
    )
}

extension DynamicFlags {
    public enum Bit: UInt32, CaseIterable {
        /// DF_ORIGIN
        case origin = 1
        /// DF_SYMBOLIC
        case symbolic = 2
        /// DF_TEXTREL
        case textrel = 4
        /// DF_BIND_NOW
        case bind_now = 8
        /// DF_STATIC_TLS
        case static_tls = 0x10
    }
}

extension DynamicFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .origin: "DF_ORIGIN"
        case .symbolic: "DF_SYMBOLIC"
        case .textrel: "DF_TEXTREL"
        case .bind_now: "DF_BIND_NOW"
        case .static_tls: "DF_STATIC_TLS"
        }
    }
}
