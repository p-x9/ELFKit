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
    public enum OS: UInt32, CaseIterable {
        /// GNU_ABI_TAG_LINUX
        case linux = 0
        /// GNU_ABI_TAG_HURD
        case hurd = 1
        /// GNU_ABI_TAG_SOLARIS
        case solaris = 2
        /// GNU_ABI_TAG_FREEBSD
        case freebsd = 3
        /// GNU_ABI_TAG_NETBSD
        case netbsd = 4
        /// GNU_ABI_TAG_SYLLABLE
        case syllable = 5
        /// GNU_ABI_TAG_NACL
        case nacl = 6
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
