//
//  ProgramType+ProcessorSpecific.swift
//  
//
//  Created by p-x9 on 2024/05/03
//  
//

import Foundation
import ELFKitC

extension ProgramType {
    public struct ProcessorSpecific: RawRepresentable {
        public typealias RawValue = UInt32
        public var rawValue: RawValue

        public var arm: ARM? {
            .init(rawValue: rawValue)
        }

        public var mips: MIPS? {
            .init(rawValue: rawValue)
        }

        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
    }
}

extension ProgramType.ProcessorSpecific: CustomStringConvertible {
    public var description: String {
        [
            arm?.description,
            mips?.description,
        ]
            .compactMap { $0 }
            .description
    }
}


// MARK: - ARM
extension ProgramType {
    public enum ARM: CaseIterable {
        /// PT_ARM_ARCHEXT
        case archext
        /// PT_ARM_EXIDX
        case exidx
    }
}

extension ProgramType.ARM: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PT_ARM_ARCHEXT): self = .archext
        case RawValue(PT_ARM_EXIDX): self = .exidx
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .archext: RawValue(PT_ARM_ARCHEXT)
        case .exidx: RawValue(PT_ARM_EXIDX)
        }
    }
}

extension ProgramType.ARM: CustomStringConvertible {
    public var description: String {
        switch self {
        case .archext: "PT_ARM_ARCHEXT"
        case .exidx: "PT_ARM_EXIDX"
        }
    }
}

// MARK: - MIPS
extension ProgramType {
    public enum MIPS: CaseIterable {
        /// PT_MIPS_REGINFO
        case reginfo
        /// PT_MIPS_RTPROC
        case rtproc
        /// PT_MIPS_OPTIONS
        case options
        /// PT_MIPS_ABIFLAGS
        case abiflags
    }
}

extension ProgramType.MIPS: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(PT_MIPS_REGINFO): self = .reginfo
        case RawValue(PT_MIPS_RTPROC): self = .rtproc
        case RawValue(PT_MIPS_OPTIONS): self = .options
        case RawValue(PT_MIPS_ABIFLAGS): self = .abiflags
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .reginfo: RawValue(PT_MIPS_REGINFO)
        case .rtproc: RawValue(PT_MIPS_RTPROC)
        case .options: RawValue(PT_MIPS_OPTIONS)
        case .abiflags: RawValue(PT_MIPS_ABIFLAGS)
        }
    }
}

extension ProgramType.MIPS: CustomStringConvertible {
    public var description: String {
        switch self {
        case .reginfo: "PT_MIPS_REGINFO"
        case .rtproc: "PT_MIPS_RTPROC"
        case .options: "PT_MIPS_OPTIONS"
        case .abiflags: "PT_MIPS_ABIFLAGS"
        }
    }
}
