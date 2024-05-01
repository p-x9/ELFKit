//
//  SectionType+GNU.swift
//
//
//  Created by p-x9 on 2024/05/01
//
//

import Foundation
import ELFKitC

extension SectionType {
    public struct OSSpecific: RawRepresentable {
        public typealias RawValue = UInt64
        public var rawValue: RawValue

        public var gnu: GNU? {
            .init(rawValue: rawValue)
        }

        public var solaris: SUNW? {
            .init(rawValue: rawValue)
        }

        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
    }
}

extension SectionType.OSSpecific: CustomStringConvertible {
    public var description: String {
        [
            gnu?.description,
            solaris?.description
        ]
            .compactMap { $0 }
            .description
    }
}

// MARK: GNU
extension SectionType {
    public enum GNU: CaseIterable {
        /// SHT_GNU_ATTRIBUTES
        case attributes
        /// SHT_GNU_HASH
        case hash
        /// SHT_GNU_LIBLIST
        case liblist
        /// SHT_GNU_verdef
        case verdef
        /// SHT_GNU_verneed
        case verneed
        /// SHT_GNU_versym
        case versym
    }
}

extension SectionType.GNU: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_GNU_ATTRIBUTES): self = .attributes
        case RawValue(SHT_GNU_HASH): self = .hash
        case RawValue(SHT_GNU_LIBLIST): self = .liblist
        case RawValue(SHT_GNU_verdef): self = .verdef
        case RawValue(SHT_GNU_verneed): self = .verneed
        case RawValue(SHT_GNU_versym): self = .versym
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .attributes: RawValue(SHT_GNU_ATTRIBUTES)
        case .hash: RawValue(SHT_GNU_HASH)
        case .liblist: RawValue(SHT_GNU_LIBLIST)
        case .verdef: RawValue(SHT_GNU_verdef)
        case .verneed: RawValue(SHT_GNU_verneed)
        case .versym: RawValue(SHT_GNU_versym)
        }
    }
}

extension SectionType.GNU: CustomStringConvertible {
    public var description: String {
        switch self {
        case .attributes: "SHT_GNU_ATTRIBUTES"
        case .hash: "SHT_GNU_HASH"
        case .liblist: "SHT_GNU_LIBLIST"
        case .verdef: "SHT_GNU_verdef"
        case .verneed: "SHT_GNU_verneed"
        case .versym: "SHT_GNU_versym"
        }
    }
}

// MARK: - SUNW
extension SectionType {
    public enum SUNW: CaseIterable {
        /// SHT_SUNW_dof
        case dof
        /// SHT_SUNW_cap
        case cap
        /// SHT_SUNW_SIGNATURE
        case signature
        /// SHT_SUNW_ANNOTATE
        case annotate
        /// SHT_SUNW_DEBUGSTR
        case debugstr
        /// SHT_SUNW_DEBUG
        case debug
        /// SHT_SUNW_move
        case move
        /// SHT_SUNW_COMDAT
        case comdat
        /// SHT_SUNW_syminfo
        case syminfo
        /// SHT_SUNW_verdef
        case verdef
        /// SHT_SUNW_verneed
        case verneed
        /// SHT_SUNW_versym
        case versym
    }
}

extension SectionType.SUNW: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_SUNW_dof): self = .dof
        case RawValue(SHT_SUNW_cap): self = .cap
        case RawValue(SHT_SUNW_SIGNATURE): self = .signature
        case RawValue(SHT_SUNW_ANNOTATE): self = .annotate
        case RawValue(SHT_SUNW_DEBUGSTR): self = .debugstr
        case RawValue(SHT_SUNW_DEBUG): self = .debug
        case RawValue(SHT_SUNW_move): self = .move
        case RawValue(SHT_SUNW_COMDAT): self = .comdat
        case RawValue(SHT_SUNW_syminfo): self = .syminfo
        case RawValue(SHT_SUNW_verdef): self = .verdef
        case RawValue(SHT_SUNW_verneed): self = .verneed
        case RawValue(SHT_SUNW_versym): self = .versym
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .dof: RawValue(SHT_SUNW_dof)
        case .cap: RawValue(SHT_SUNW_cap)
        case .signature: RawValue(SHT_SUNW_SIGNATURE)
        case .annotate: RawValue(SHT_SUNW_ANNOTATE)
        case .debugstr: RawValue(SHT_SUNW_DEBUGSTR)
        case .debug: RawValue(SHT_SUNW_DEBUG)
        case .move: RawValue(SHT_SUNW_move)
        case .comdat: RawValue(SHT_SUNW_COMDAT)
        case .syminfo: RawValue(SHT_SUNW_syminfo)
        case .verdef: RawValue(SHT_SUNW_verdef)
        case .verneed: RawValue(SHT_SUNW_verneed)
        case .versym: RawValue(SHT_SUNW_versym)
        }
    }
}

extension SectionType.SUNW: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dof: "SHT_SUNW_dof"
        case .cap: "SHT_SUNW_cap"
        case .signature: "SHT_SUNW_SIGNATURE"
        case .annotate: "SHT_SUNW_ANNOTATE"
        case .debugstr: "SHT_SUNW_DEBUGSTR"
        case .debug: "SHT_SUNW_DEBUG"
        case .move: "SHT_SUNW_move"
        case .comdat: "SHT_SUNW_COMDAT"
        case .syminfo: "SHT_SUNW_syminfo"
        case .verdef: "SHT_SUNW_verdef"
        case .verneed: "SHT_SUNW_verneed"
        case .versym: "SHT_SUNW_versym"
        }
    }
}
