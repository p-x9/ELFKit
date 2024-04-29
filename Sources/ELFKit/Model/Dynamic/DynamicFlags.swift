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
    public enum Bit: CaseIterable {
        /// DF_ORIGIN
        case origin
        /// DF_SYMBOLIC
        case symbolic
        /// DF_TEXTREL
        case textrel
        /// DF_BIND_NOW
        case bind_now
        /// DF_STATIC_TLS
        case static_tls
    }
}

extension DynamicFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DF_ORIGIN): self = .origin
        case RawValue(DF_SYMBOLIC): self = .symbolic
        case RawValue(DF_TEXTREL): self = .textrel
        case RawValue(DF_BIND_NOW): self = .bind_now
        case RawValue(DF_STATIC_TLS): self = .static_tls
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .origin: RawValue(DF_ORIGIN)
        case .symbolic: RawValue(DF_SYMBOLIC)
        case .textrel: RawValue(DF_TEXTREL)
        case .bind_now: RawValue(DF_BIND_NOW)
        case .static_tls: RawValue(DF_STATIC_TLS)
        }
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
