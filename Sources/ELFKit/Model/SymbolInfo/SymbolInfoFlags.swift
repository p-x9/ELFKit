//
//  SymbolInfoFlags.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct SymbolInfoFlags: BitFlags {
    public typealias RawValue = UInt16

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension SymbolInfoFlags {
    /// SYMINFO_FLG_DIRECT
    public static let direct = SymbolInfoFlags(
        rawValue: Bit.direct.rawValue
    )
    /// SYMINFO_FLG_FILTER
    public static let filter = SymbolInfoFlags(
        rawValue: Bit.filter.rawValue
    )
    /// SYMINFO_FLG_COPY
    public static let copy = SymbolInfoFlags(
        rawValue: Bit.copy.rawValue
    )
    /// SYMINFO_FLG_LAZYLOAD
    public static let lazyload = SymbolInfoFlags(
        rawValue: Bit.lazyload.rawValue
    )
    /// SYMINFO_FLG_DIRECTBIND
    public static let directbind = SymbolInfoFlags(
        rawValue: Bit.directbind.rawValue
    )
    /// SYMINFO_FLG_NOEXTDIRECT
    public static let noextdirect = SymbolInfoFlags(
        rawValue: Bit.noextdirect.rawValue
    )
    /// SYMINFO_FLG_AUXILIARY
    public static let auxiliary = SymbolInfoFlags(
        rawValue: Bit.auxiliary.rawValue
    )
    /// SYMINFO_FLG_INTERPOSE
    public static let interpose = SymbolInfoFlags(
        rawValue: Bit.interpose.rawValue
    )
    /// SYMINFO_FLG_CAP
    public static let cap = SymbolInfoFlags(
        rawValue: Bit.cap.rawValue
    )
    /// SYMINFO_FLG_DEFERRED
    public static let deferred = SymbolInfoFlags(
        rawValue: Bit.deferred.rawValue
    )
}

extension SymbolInfoFlags {
    public enum Bit: UInt16, CaseIterable {
        /// SYMINFO_FLG_DIRECT
        case direct = 1
        /// SYMINFO_FLG_FILTER
        case filter = 2
        /// SYMINFO_FLG_COPY
        case copy = 4
        /// SYMINFO_FLG_LAZYLOAD
        case lazyload = 8
        /// SYMINFO_FLG_DIRECTBIND
        case directbind = 0x10
        /// SYMINFO_FLG_NOEXTDIRECT
        case noextdirect = 0x20
        /// SYMINFO_FLG_AUXILIARY
        case auxiliary = 0x40
        /// SYMINFO_FLG_INTERPOSE
        case interpose = 0x80
        /// SYMINFO_FLG_CAP
        case cap = 0x100
        /// SYMINFO_FLG_DEFERRED
        case deferred = 0x200
    }
}

extension SymbolInfoFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .direct: "SYMINFO_FLG_DIRECT"
        case .filter: "SYMINFO_FLG_FILTER"
        case .copy: "SYMINFO_FLG_COPY"
        case .lazyload: "SYMINFO_FLG_LAZYLOAD"
        case .directbind: "SYMINFO_FLG_DIRECTBIND"
        case .noextdirect: "SYMINFO_FLG_NOEXTDIRECT"
        case .auxiliary: "SYMINFO_FLG_AUXILIARY"
        case .interpose: "SYMINFO_FLG_INTERPOSE"
        case .cap: "SYMINFO_FLG_CAP"
        case .deferred: "SYMINFO_FLG_DEFERRED"
        }
    }
}
