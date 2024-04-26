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
    /// SHF_RELA_LIVEPATCH
    public static let rela_livepatch = SectionFlags(
        rawValue: Bit.rela_livepatch.rawValue
    )
    /// SHF_RO_AFTER_INIT
    public static let ro_after_init = SectionFlags(
        rawValue: Bit.ro_after_init.rawValue
    )
    /// SHF_MASKPROC
    public static let maskproc = SectionFlags(
        rawValue: Bit.maskproc.rawValue
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
        /// SHF_RELA_LIVEPATCH
        case rela_livepatch
        /// SHF_RO_AFTER_INIT
        case ro_after_init
        /// SHF_MASKPROC
        case maskproc
    }
}

extension SectionFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHF_WRITE): self = .write
        case RawValue(SHF_ALLOC): self = .alloc
        case RawValue(SHF_EXECINSTR): self = .execinstr
        case RawValue(SHF_RELA_LIVEPATCH): self = .rela_livepatch
        case RawValue(SHF_RO_AFTER_INIT): self = .ro_after_init
        case RawValue(SHF_MASKPROC): self = .maskproc
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .write: RawValue(SHF_WRITE)
        case .alloc: RawValue(SHF_ALLOC)
        case .execinstr: RawValue(SHF_EXECINSTR)
        case .rela_livepatch: RawValue(SHF_RELA_LIVEPATCH)
        case .ro_after_init: RawValue(SHF_RO_AFTER_INIT)
        case .maskproc: RawValue(SHF_MASKPROC)
        }
    }
}

extension SectionFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .write: "SHF_WRITE"
        case .alloc: "SHF_ALLOC"
        case .execinstr: "SHF_EXECINSTR"
        case .rela_livepatch: "SHF_RELA_LIVEPATCH"
        case .ro_after_init: "SHF_RO_AFTER_INIT"
        case .maskproc: "SHF_MASKPROC"
        }
    }
}
