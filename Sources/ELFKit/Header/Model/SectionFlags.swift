//
//  SectionFlags.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
import ELFKitC

public struct SectionFlags: BitFlags {
    public typealias RawValue = UInt64

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension SectionFlags {
    public var isOSSpecific: Bool {
        (rawValue & numericCast(SHF_MASKOS)) > 0
    }

    public var isProcessorSpecific: Bool {
        (rawValue & numericCast(SHF_MASKPROC)) > 0
    }
}

extension SectionFlags {
    /// SHF_WRITE
    public static let write = SectionFlags(
        rawValue: Bit.write.rawValue
    )
    /// SHF_ALLOC
    public static let alloc = SectionFlags(
        rawValue: Bit.alloc.rawValue
    )
    /// SHF_EXECINSTR
    public static let execinstr = SectionFlags(
        rawValue: Bit.execinstr.rawValue
    )
    /// SHF_MERGE
    public static let merge = SectionFlags(
        rawValue: Bit.merge.rawValue
    )
    /// SHF_STRINGS
    public static let strings = SectionFlags(
        rawValue: Bit.strings.rawValue
    )
    /// SHF_INFO_LINK
    public static let info_link = SectionFlags(
        rawValue: Bit.info_link.rawValue
    )
    /// SHF_LINK_ORDER
    public static let link_order = SectionFlags(
        rawValue: Bit.link_order.rawValue
    )
    /// SHF_OS_NONCONFORMING
    public static let os_nonconforming = SectionFlags(
        rawValue: Bit.os_nonconforming.rawValue
    )
    /// SHF_GROUP
    public static let group = SectionFlags(
        rawValue: Bit.group.rawValue
    )
    /// SHF_TLS
    public static let tls = SectionFlags(
        rawValue: Bit.tls.rawValue
    )
    /// SHF_COMPRESSED
    public static let compressed = SectionFlags(
        rawValue: Bit.compressed.rawValue
    )
}

extension SectionFlags {
    public enum Bit: CaseIterable {
        /// SHF_WRITE
        case write
        /// SHF_ALLOC
        case alloc
        /// SHF_EXECINSTR
        case execinstr
        /// SHF_MERGE
        case merge
        /// SHF_STRINGS
        case strings
        /// SHF_INFO_LINK
        case info_link
        /// SHF_LINK_ORDER
        case link_order
        /// SHF_OS_NONCONFORMING
        case os_nonconforming
        /// SHF_GROUP
        case group
        /// SHF_TLS
        case tls
        /// SHF_COMPRESSED
        case compressed
    }
}

extension SectionFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHF_WRITE): self = .write
        case RawValue(SHF_ALLOC): self = .alloc
        case RawValue(SHF_EXECINSTR): self = .execinstr
        case RawValue(SHF_MERGE): self = .merge
        case RawValue(SHF_STRINGS): self = .strings
        case RawValue(SHF_INFO_LINK): self = .info_link
        case RawValue(SHF_LINK_ORDER): self = .link_order
        case RawValue(SHF_OS_NONCONFORMING): self = .os_nonconforming
        case RawValue(SHF_GROUP): self = .group
        case RawValue(SHF_TLS): self = .tls
        case RawValue(SHF_COMPRESSED): self = .compressed
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .write: RawValue(SHF_WRITE)
        case .alloc: RawValue(SHF_ALLOC)
        case .execinstr: RawValue(SHF_EXECINSTR)
        case .merge: RawValue(SHF_MERGE)
        case .strings: RawValue(SHF_STRINGS)
        case .info_link: RawValue(SHF_INFO_LINK)
        case .link_order: RawValue(SHF_LINK_ORDER)
        case .os_nonconforming: RawValue(SHF_OS_NONCONFORMING)
        case .group: RawValue(SHF_GROUP)
        case .tls: RawValue(SHF_TLS)
        case .compressed: RawValue(SHF_COMPRESSED)
        }
    }
}

extension SectionFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .write: "SHF_WRITE"
        case .alloc: "SHF_ALLOC"
        case .execinstr: "SHF_EXECINSTR"
        case .merge: "SHF_MERGE"
        case .strings: "SHF_STRINGS"
        case .info_link: "SHF_INFO_LINK"
        case .link_order: "SHF_LINK_ORDER"
        case .os_nonconforming: "SHF_OS_NONCONFORMING"
        case .group: "SHF_GROUP"
        case .tls: "SHF_TLS"
        case .compressed: "SHF_COMPRESSED"
        }
    }
}
