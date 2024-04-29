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
    /// SYMINFO_FLG_PASSTHRU
    public static let passthru = SymbolInfoFlags(
        rawValue: Bit.passthru.rawValue
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
    /// SYMINFO_FLG_FILTER
    public static let filter = SymbolInfoFlags(
        rawValue: Bit.filter.rawValue
    )
    /// SYMINFO_FLG_AUXILIARY
    public static let auxiliary = SymbolInfoFlags(
        rawValue: Bit.auxiliary.rawValue
    )
}

extension SymbolInfoFlags {
    public enum Bit: CaseIterable {
        /// SYMINFO_FLG_DIRECT
        case direct
        /// SYMINFO_FLG_PASSTHRU
        case passthru
        /// SYMINFO_FLG_COPY
        case copy
        /// SYMINFO_FLG_LAZYLOAD
        case lazyload
        /// SYMINFO_FLG_DIRECTBIND
        case directbind
        /// SYMINFO_FLG_NOEXTDIRECT
        case noextdirect
        /// SYMINFO_FLG_FILTER
        case filter
        /// SYMINFO_FLG_AUXILIARY
        case auxiliary
    }
}

extension SymbolInfoFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt16

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SYMINFO_FLG_DIRECT): self = .direct
        case RawValue(SYMINFO_FLG_PASSTHRU): self = .passthru
        case RawValue(SYMINFO_FLG_COPY): self = .copy
        case RawValue(SYMINFO_FLG_LAZYLOAD): self = .lazyload
        case RawValue(SYMINFO_FLG_DIRECTBIND): self = .directbind
        case RawValue(SYMINFO_FLG_NOEXTDIRECT): self = .noextdirect
        case RawValue(SYMINFO_FLG_FILTER): self = .filter
        case RawValue(SYMINFO_FLG_AUXILIARY): self = .auxiliary
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .direct: RawValue(SYMINFO_FLG_DIRECT)
        case .passthru: RawValue(SYMINFO_FLG_PASSTHRU)
        case .copy: RawValue(SYMINFO_FLG_COPY)
        case .lazyload: RawValue(SYMINFO_FLG_LAZYLOAD)
        case .directbind: RawValue(SYMINFO_FLG_DIRECTBIND)
        case .noextdirect: RawValue(SYMINFO_FLG_NOEXTDIRECT)
        case .filter: RawValue(SYMINFO_FLG_FILTER)
        case .auxiliary: RawValue(SYMINFO_FLG_AUXILIARY)
        }
    }
}


extension SymbolInfoFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .direct: "SYMINFO_FLG_DIRECT"
        case .passthru: "SYMINFO_FLG_PASSTHRU"
        case .copy: "SYMINFO_FLG_COPY"
        case .lazyload: "SYMINFO_FLG_LAZYLOAD"
        case .directbind: "SYMINFO_FLG_DIRECTBIND"
        case .noextdirect: "SYMINFO_FLG_NOEXTDIRECT"
        case .filter: "SYMINFO_FLG_FILTER"
        case .auxiliary: "SYMINFO_FLG_AUXILIARY"
        }
    }
}
