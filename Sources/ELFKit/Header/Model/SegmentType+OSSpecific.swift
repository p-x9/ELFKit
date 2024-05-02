//
//  SegmentType+OSSpecific.swift
//
//
//  Created by p-x9 on 2024/05/03
//  
//

import Foundation
import ELFKitC

extension SegmentType {
    public struct OSSpecific: RawRepresentable {
        public typealias RawValue = UInt32
        public var rawValue: RawValue

        public var gnu: GNU? {
            .init(rawValue: rawValue)
        }

        public var solaris: SUNW? {
            .init(rawValue: rawValue)
        }

        public var openBSD: OpenBSD? {
            .init(rawValue: rawValue)
        }

        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
    }
}

extension SegmentType.OSSpecific: CustomStringConvertible {
    public var description: String {
        [
            gnu?.description,
            solaris?.description,
            openBSD?.description
        ]
            .compactMap { $0 }
            .description
    }
}

// MARK: GNU
extension SegmentType {
    public enum GNU: CaseIterable {
        /// PT_GNU_EH_FRAME
        case eh_frame
        /// PT_GNU_STACK
        case stack
        /// PT_GNU_RELRO
        case relro
    }
}

extension SegmentType.GNU: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PT_GNU_EH_FRAME): self = .eh_frame
        case RawValue(PT_GNU_STACK): self = .stack
        case RawValue(PT_GNU_RELRO): self = .relro
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .eh_frame: RawValue(PT_GNU_EH_FRAME)
        case .stack: RawValue(PT_GNU_STACK)
        case .relro: RawValue(PT_GNU_RELRO)
        }
    }
}

extension SegmentType.GNU: CustomStringConvertible {
    public var description: String {
        switch self {
        case .eh_frame: "PT_GNU_EH_FRAME"
        case .stack: "PT_GNU_STACK"
        case .relro: "PT_GNU_RELRO"
        }
    }
}

// MARK: - SUNW
extension SegmentType {
    public enum SUNW: CaseIterable {
        /// PT_SUNW_UNWIND
        case unwind
        /// PT_SUNWBSS
        case bss
        /// PT_SUNWSTACK
        case stack
        /// PT_SUNWDTRACE
        case dtrace
        /// PT_SUNWCAP
        case cap
    }
}

extension SegmentType.SUNW: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PT_SUNW_UNWIND): self = .unwind
        case RawValue(PT_SUNWBSS): self = .bss
        case RawValue(PT_SUNWSTACK): self = .stack
        case RawValue(PT_SUNWDTRACE): self = .dtrace
        case RawValue(PT_SUNWCAP): self = .cap
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .unwind: RawValue(PT_SUNW_UNWIND)
        case .bss: RawValue(PT_SUNWBSS)
        case .stack: RawValue(PT_SUNWSTACK)
        case .dtrace: RawValue(PT_SUNWDTRACE)
        case .cap: RawValue(PT_SUNWCAP)
        }
    }
}

extension SegmentType.SUNW: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unwind: "PT_SUNW_UNWIND"
        case .bss: "PT_SUNWBSS"
        case .stack: "PT_SUNWSTACK"
        case .dtrace: "PT_SUNWDTRACE"
        case .cap: "PT_SUNWCAP"
        }
    }
}

// MARK: - OpenBSD
extension SegmentType {
    public enum OpenBSD: CaseIterable {
        /// PT_OPENBSD_RANDOMIZE
        case randomize
        /// PT_OPENBSD_WXNEEDED
        case wxneeded
        /// PT_OPENBSD_BOOTDATA
        case bootdata
    }
}

extension SegmentType.OpenBSD: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PT_OPENBSD_RANDOMIZE): self = .randomize
        case RawValue(PT_OPENBSD_WXNEEDED): self = .wxneeded
        case RawValue(PT_OPENBSD_BOOTDATA): self = .bootdata
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .randomize: RawValue(PT_OPENBSD_RANDOMIZE)
        case .wxneeded: RawValue(PT_OPENBSD_WXNEEDED)
        case .bootdata: RawValue(PT_OPENBSD_BOOTDATA)
        }
    }
}

extension SegmentType.OpenBSD: CustomStringConvertible {
    public var description: String {
        switch self {
        case .randomize: "PT_OPENBSD_RANDOMIZE"
        case .wxneeded: "PT_OPENBSD_WXNEEDED"
        case .bootdata: "PT_OPENBSD_BOOTDATA"
        }
    }
}
