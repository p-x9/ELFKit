//
//  DynamicFlags1.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct DynamicFlags1: BitFlags {
    public typealias RawValue = UInt32

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension DynamicFlags1 {
    /// DF_1_BIND_NOW
    public static let bind_now = DynamicFlags1(
        rawValue: Bit.bind_now.rawValue
    )
    /// DF_1_GLOBAL
    public static let global = DynamicFlags1(
        rawValue: Bit.global.rawValue
    )
    /// DF_1_NODELETE
    public static let nodelete = DynamicFlags1(
        rawValue: Bit.nodelete.rawValue
    )
    /// DF_1_LOADFLTR
    public static let loadfltr = DynamicFlags1(
        rawValue: Bit.loadfltr.rawValue
    )
    /// DF_1_NOOPEN
    public static let noopen = DynamicFlags1(
        rawValue: Bit.noopen.rawValue
    )
    /// DF_1_ORIGIN
    public static let origin = DynamicFlags1(
        rawValue: Bit.origin.rawValue
    )
    /// DF_1_INTERPOSE
    public static let interpose = DynamicFlags1(
        rawValue: Bit.interpose.rawValue
    )
    /// DF_1_NODEFLIB
    public static let nodeflib = DynamicFlags1(
        rawValue: Bit.nodeflib.rawValue
    )
    /// DF_1_PIE
    public static let pie = DynamicFlags1(
        rawValue: Bit.pie.rawValue
    )
}

extension DynamicFlags1 {
    public enum Bit: CaseIterable {
        /// DF_1_BIND_NOW
        case bind_now
        /// DF_1_GLOBAL
        case global
        /// DF_1_NODELETE
        case nodelete
        /// DF_1_LOADFLTR
        case loadfltr
        /// DF_1_NOOPEN
        case noopen
        /// DF_1_ORIGIN
        case origin
        /// DF_1_INTERPOSE
        case interpose
        /// DF_1_NODEFLIB
        case nodeflib
        /// DF_1_PIE
        case pie
    }
}

extension DynamicFlags1.Bit: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DF_1_BIND_NOW): self = .bind_now
        case RawValue(DF_1_GLOBAL): self = .global
        case RawValue(DF_1_NODELETE): self = .nodelete
        case RawValue(DF_1_LOADFLTR): self = .loadfltr
        case RawValue(DF_1_NOOPEN): self = .noopen
        case RawValue(DF_1_ORIGIN): self = .origin
        case RawValue(DF_1_INTERPOSE): self = .interpose
        case RawValue(DF_1_NODEFLIB): self = .nodeflib
        case RawValue(DF_1_PIE): self = .pie
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .bind_now: RawValue(DF_1_BIND_NOW)
        case .global: RawValue(DF_1_GLOBAL)
        case .nodelete: RawValue(DF_1_NODELETE)
        case .loadfltr: RawValue(DF_1_LOADFLTR)
        case .noopen: RawValue(DF_1_NOOPEN)
        case .origin: RawValue(DF_1_ORIGIN)
        case .interpose: RawValue(DF_1_INTERPOSE)
        case .nodeflib: RawValue(DF_1_NODEFLIB)
        case .pie: RawValue(DF_1_PIE)
        }
    }
}


extension DynamicFlags1.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bind_now: "DF_1_BIND_NOW"
        case .global: "DF_1_GLOBAL"
        case .nodelete: "DF_1_NODELETE"
        case .loadfltr: "DF_1_LOADFLTR"
        case .noopen: "DF_1_NOOPEN"
        case .origin: "DF_1_ORIGIN"
        case .interpose: "DF_1_INTERPOSE"
        case .nodeflib: "DF_1_NODEFLIB"
        case .pie: "DF_1_PIE"
        }
    }
}
