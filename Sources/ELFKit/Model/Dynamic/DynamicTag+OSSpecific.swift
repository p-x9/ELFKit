//
//  DynamicTag+OSSpecific.swift
//
//
//  Created by p-x9 on 2024/05/03
//  
//

import Foundation
import ELFKitC

extension DynamicTag {
    public struct OSSpecific: RawRepresentable {
        public typealias RawValue = UInt64
        public var rawValue: RawValue

        public var solaris: SUNW? {
            .init(rawValue: rawValue)
        }

        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
    }
}

extension DynamicTag.OSSpecific: CustomStringConvertible {
    public var description: String {
        [
            solaris?.description,
        ]
            .compactMap { $0 }
            .description
    }
}

// MARK: - SUNW
extension DynamicTag {
    public enum SUNW: CaseIterable {
        /// DT_SUNW_AUXILIARY
        case auxiliary
        /// DT_SUNW_RTLDINF
        case rtldinf
        /// DT_SUNW_FILTER
        case filter
        /// DT_SUNW_CAP
        case cap
        /// DT_SUNW_ASLR
        case aslr
    }
}

extension DynamicTag.SUNW: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DT_SUNW_AUXILIARY): self = .auxiliary
        case RawValue(DT_SUNW_RTLDINF): self = .rtldinf
        case RawValue(DT_SUNW_FILTER): self = .filter
        case RawValue(DT_SUNW_CAP): self = .cap
        case RawValue(DT_SUNW_ASLR): self = .aslr
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .auxiliary: RawValue(DT_SUNW_AUXILIARY)
        case .rtldinf: RawValue(DT_SUNW_RTLDINF)
        case .filter: RawValue(DT_SUNW_FILTER)
        case .cap: RawValue(DT_SUNW_CAP)
        case .aslr: RawValue(DT_SUNW_ASLR)
        }
    }
}

extension DynamicTag.SUNW: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auxiliary: "DT_SUNW_AUXILIARY"
        case .rtldinf: "DT_SUNW_RTLDINF"
        case .filter: "DT_SUNW_FILTER"
        case .cap: "DT_SUNW_CAP"
        case .aslr: "DT_SUNW_ASLR"
        }
    }
}
