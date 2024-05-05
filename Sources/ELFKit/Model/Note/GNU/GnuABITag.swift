//
//  GnuABITag.swift
//
//
//  Created by p-x9 on 2024/05/05
//  
//

import Foundation

public struct GnuABITag: LayoutWrapper {
    public struct Layout {
        let os: UInt32
        let major, minor, patch: UInt32
    }

    public var layout: Layout
}

extension GnuABITag {
    init?(data: Data) {
        guard data.count >= Self.layoutSize else {
            return nil
        }
        let data = Array(data)
        let os = data[0..<4]
            .withUnsafeBytes({ $0.load(as: UInt32.self) })
        let major = data[4..<8]
            .withUnsafeBytes({ $0.load(as: UInt32.self) })
        let minor = data[8..<12]
            .withUnsafeBytes({ $0.load(as: UInt32.self) })
        let subminor = data[12..<16]
            .withUnsafeBytes({ $0.load(as: UInt32.self) })
        self.init(
            layout: .init(
                os: os,
                major: major,
                minor: minor,
                patch: subminor
            )
        )
    }
}

extension GnuABITag {
    public var os: OS! {
        .init(rawValue: layout.os)
    }

    public var version: Version {
        .init(
            major: numericCast(layout.major),
            minor: numericCast(layout.minor),
            patch: numericCast(layout.patch)
        )
    }
}

extension GnuABITag {
    public enum OS: CaseIterable {
        /// GNU_ABI_TAG_LINUX
        case linux
        /// GNU_ABI_TAG_HURD
        case hurd
        /// GNU_ABI_TAG_SOLARIS
        case solaris
        /// GNU_ABI_TAG_FREEBSD
        case freebsd
        /// GNU_ABI_TAG_NETBSD
        case netbsd
        /// GNU_ABI_TAG_SYLLABLE
        case syllable
        /// GNU_ABI_TAG_NACL
        case nacl
    }
}

extension GnuABITag.OS: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(GNU_ABI_TAG_LINUX): self = .linux
        case RawValue(GNU_ABI_TAG_HURD): self = .hurd
        case RawValue(GNU_ABI_TAG_SOLARIS): self = .solaris
        case RawValue(GNU_ABI_TAG_FREEBSD): self = .freebsd
        case RawValue(GNU_ABI_TAG_NETBSD): self = .netbsd
        case RawValue(GNU_ABI_TAG_SYLLABLE): self = .syllable
        case RawValue(GNU_ABI_TAG_NACL): self = .nacl
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .linux: RawValue(GNU_ABI_TAG_LINUX)
        case .hurd: RawValue(GNU_ABI_TAG_HURD)
        case .solaris: RawValue(GNU_ABI_TAG_SOLARIS)
        case .freebsd: RawValue(GNU_ABI_TAG_FREEBSD)
        case .netbsd: RawValue(GNU_ABI_TAG_NETBSD)
        case .syllable: RawValue(GNU_ABI_TAG_SYLLABLE)
        case .nacl: RawValue(GNU_ABI_TAG_NACL)
        }
    }
}

extension GnuABITag.OS: CustomStringConvertible {
    public var description: String {
        switch self {
        case .linux: "GNU_ABI_TAG_LINUX"
        case .hurd: "GNU_ABI_TAG_HURD"
        case .solaris: "GNU_ABI_TAG_SOLARIS"
        case .freebsd: "GNU_ABI_TAG_FREEBSD"
        case .netbsd: "GNU_ABI_TAG_NETBSD"
        case .syllable: "GNU_ABI_TAG_SYLLABLE"
        case .nacl: "GNU_ABI_TAG_NACL"
        }
    }
}
