//
//  SectionType+ProcessorSpecific.swift
//
//
//  Created by p-x9 on 2024/05/01
//  
//

import Foundation
import ELFKitC

extension SectionType {
    public struct ProcessorSpecific: RawRepresentable {
        public typealias RawValue = UInt64
        public var rawValue: RawValue

        public var x86_64: X86_64? {
            .init(rawValue: rawValue)
        }

        public var arm: ARM? {
            .init(rawValue: rawValue)
        }

        public var mips: MIPS? {
            .init(rawValue: rawValue)
        }

        public var sparc: SPARC? {
            .init(rawValue: rawValue)
        }

        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
    }
}

extension SectionType.ProcessorSpecific: CustomStringConvertible {
    public var description: String {
        [
            x86_64?.description,
            arm?.description,
            mips?.description,
            sparc?.description
        ]
            .compactMap { $0 }
            .description
    }
}

// MARK: - X86_64
extension SectionType {
    public enum X86_64: CaseIterable {
        /// SHT_X86_64_UNWIND
        case unwind
    }
}

extension SectionType.X86_64: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_X86_64_UNWIND): self = .unwind
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .unwind: RawValue(SHT_X86_64_UNWIND)
        }
    }
}

extension SectionType.X86_64: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unwind: "SHT_X86_64_UNWIND"
        }
    }
}

// MARK: - ARM
extension SectionType {
    public enum ARM: CaseIterable {
        /// SHT_ARM_EXIDX
        case exidx
        /// SHT_ARM_PREEMPTMAP
        case preemptmap
        /// SHT_ARM_ATTRIBUTES
        case attributes
        /// SHT_ARM_DEBUGOVERLAY
        case debugoverlay
        /// SHT_ARM_OVERLAYSECTION
        case overlaysection
    }
}

extension SectionType.ARM: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_ARM_EXIDX): self = .exidx
        case RawValue(SHT_ARM_PREEMPTMAP): self = .preemptmap
        case RawValue(SHT_ARM_ATTRIBUTES): self = .attributes
        case RawValue(SHT_ARM_DEBUGOVERLAY): self = .debugoverlay
        case RawValue(SHT_ARM_OVERLAYSECTION): self = .overlaysection
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .exidx: RawValue(SHT_ARM_EXIDX)
        case .preemptmap: RawValue(SHT_ARM_PREEMPTMAP)
        case .attributes: RawValue(SHT_ARM_ATTRIBUTES)
        case .debugoverlay: RawValue(SHT_ARM_DEBUGOVERLAY)
        case .overlaysection: RawValue(SHT_ARM_OVERLAYSECTION)
        }
    }
}

extension SectionType.ARM: CustomStringConvertible {
    public var description: String {
        switch self {
        case .exidx: "SHT_ARM_EXIDX"
        case .preemptmap: "SHT_ARM_PREEMPTMAP"
        case .attributes: "SHT_ARM_ATTRIBUTES"
        case .debugoverlay: "SHT_ARM_DEBUGOVERLAY"
        case .overlaysection: "SHT_ARM_OVERLAYSECTION"
        }
    }
}

// MARK: - MIPS
extension SectionType {
    public enum MIPS: CaseIterable {
        /// SHT_MIPS_LIBLIST
        case liblist
        /// SHT_MIPS_MSYM
        case msym
        /// SHT_MIPS_CONFLICT
        case conflict
        /// SHT_MIPS_GPTAB
        case gptab
        /// SHT_MIPS_UCODE
        case ucode
        /// SHT_MIPS_DEBUG
        case debug
        /// SHT_MIPS_REGINFO
        case reginfo
        /// SHT_MIPS_PACKAGE
        case package
        /// SHT_MIPS_PACKSYM
        case packsym
        /// SHT_MIPS_RELD
        case reld
        /// SHT_MIPS_IFACE
        case iface
        /// SHT_MIPS_CONTENT
        case content
        /// SHT_MIPS_OPTIONS
        case options
        /// SHT_MIPS_DELTASYM
        case deltasym
        /// SHT_MIPS_DELTAINST
        case deltainst
        /// SHT_MIPS_DELTACLASS
        case deltaclass
        /// SHT_MIPS_DWARF
        case dwarf
        /// SHT_MIPS_DELTADECL
        case deltadecl
        /// SHT_MIPS_SYMBOL_LIB
        case symbol_lib
        /// SHT_MIPS_EVENTS
        case events
        /// SHT_MIPS_TRANSLATE
        case translate
        /// SHT_MIPS_PIXIE
        case pixie
        /// SHT_MIPS_XLATE
        case xlate
        /// SHT_MIPS_XLATE_DEBUG
        case xlate_debug
        /// SHT_MIPS_WHIRL
        case whirl
        /// SHT_MIPS_EH_REGION
        case eh_region
        /// SHT_MIPS_XLATE_OLD
        case xlate_old
        /// SHT_MIPS_PDR_EXCEPTION
        case pdr_exception
        /// SHT_MIPS_ABIFLAGS
        case abiflags
    }
}

extension SectionType.MIPS: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_MIPS_LIBLIST): self = .liblist
        case RawValue(SHT_MIPS_MSYM): self = .msym
        case RawValue(SHT_MIPS_CONFLICT): self = .conflict
        case RawValue(SHT_MIPS_GPTAB): self = .gptab
        case RawValue(SHT_MIPS_UCODE): self = .ucode
        case RawValue(SHT_MIPS_DEBUG): self = .debug
        case RawValue(SHT_MIPS_REGINFO): self = .reginfo
        case RawValue(SHT_MIPS_PACKAGE): self = .package
        case RawValue(SHT_MIPS_PACKSYM): self = .packsym
        case RawValue(SHT_MIPS_RELD): self = .reld
        case RawValue(SHT_MIPS_IFACE): self = .iface
        case RawValue(SHT_MIPS_CONTENT): self = .content
        case RawValue(SHT_MIPS_OPTIONS): self = .options
        case RawValue(SHT_MIPS_DELTASYM): self = .deltasym
        case RawValue(SHT_MIPS_DELTAINST): self = .deltainst
        case RawValue(SHT_MIPS_DELTACLASS): self = .deltaclass
        case RawValue(SHT_MIPS_DWARF): self = .dwarf
        case RawValue(SHT_MIPS_DELTADECL): self = .deltadecl
        case RawValue(SHT_MIPS_SYMBOL_LIB): self = .symbol_lib
        case RawValue(SHT_MIPS_EVENTS): self = .events
        case RawValue(SHT_MIPS_TRANSLATE): self = .translate
        case RawValue(SHT_MIPS_PIXIE): self = .pixie
        case RawValue(SHT_MIPS_XLATE): self = .xlate
        case RawValue(SHT_MIPS_XLATE_DEBUG): self = .xlate_debug
        case RawValue(SHT_MIPS_WHIRL): self = .whirl
        case RawValue(SHT_MIPS_EH_REGION): self = .eh_region
        case RawValue(SHT_MIPS_XLATE_OLD): self = .xlate_old
        case RawValue(SHT_MIPS_PDR_EXCEPTION): self = .pdr_exception
        case RawValue(SHT_MIPS_ABIFLAGS): self = .abiflags
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .liblist: RawValue(SHT_MIPS_LIBLIST)
        case .msym: RawValue(SHT_MIPS_MSYM)
        case .conflict: RawValue(SHT_MIPS_CONFLICT)
        case .gptab: RawValue(SHT_MIPS_GPTAB)
        case .ucode: RawValue(SHT_MIPS_UCODE)
        case .debug: RawValue(SHT_MIPS_DEBUG)
        case .reginfo: RawValue(SHT_MIPS_REGINFO)
        case .package: RawValue(SHT_MIPS_PACKAGE)
        case .packsym: RawValue(SHT_MIPS_PACKSYM)
        case .reld: RawValue(SHT_MIPS_RELD)
        case .iface: RawValue(SHT_MIPS_IFACE)
        case .content: RawValue(SHT_MIPS_CONTENT)
        case .options: RawValue(SHT_MIPS_OPTIONS)
        case .deltasym: RawValue(SHT_MIPS_DELTASYM)
        case .deltainst: RawValue(SHT_MIPS_DELTAINST)
        case .deltaclass: RawValue(SHT_MIPS_DELTACLASS)
        case .dwarf: RawValue(SHT_MIPS_DWARF)
        case .deltadecl: RawValue(SHT_MIPS_DELTADECL)
        case .symbol_lib: RawValue(SHT_MIPS_SYMBOL_LIB)
        case .events: RawValue(SHT_MIPS_EVENTS)
        case .translate: RawValue(SHT_MIPS_TRANSLATE)
        case .pixie: RawValue(SHT_MIPS_PIXIE)
        case .xlate: RawValue(SHT_MIPS_XLATE)
        case .xlate_debug: RawValue(SHT_MIPS_XLATE_DEBUG)
        case .whirl: RawValue(SHT_MIPS_WHIRL)
        case .eh_region: RawValue(SHT_MIPS_EH_REGION)
        case .xlate_old: RawValue(SHT_MIPS_XLATE_OLD)
        case .pdr_exception: RawValue(SHT_MIPS_PDR_EXCEPTION)
        case .abiflags: RawValue(SHT_MIPS_ABIFLAGS)
        }
    }
}

extension SectionType.MIPS: CustomStringConvertible {
    public var description: String {
        switch self {
        case .liblist: "SHT_MIPS_LIBLIST"
        case .msym: "SHT_MIPS_MSYM"
        case .conflict: "SHT_MIPS_CONFLICT"
        case .gptab: "SHT_MIPS_GPTAB"
        case .ucode: "SHT_MIPS_UCODE"
        case .debug: "SHT_MIPS_DEBUG"
        case .reginfo: "SHT_MIPS_REGINFO"
        case .package: "SHT_MIPS_PACKAGE"
        case .packsym: "SHT_MIPS_PACKSYM"
        case .reld: "SHT_MIPS_RELD"
        case .iface: "SHT_MIPS_IFACE"
        case .content: "SHT_MIPS_CONTENT"
        case .options: "SHT_MIPS_OPTIONS"
        case .deltasym: "SHT_MIPS_DELTASYM"
        case .deltainst: "SHT_MIPS_DELTAINST"
        case .deltaclass: "SHT_MIPS_DELTACLASS"
        case .dwarf: "SHT_MIPS_DWARF"
        case .deltadecl: "SHT_MIPS_DELTADECL"
        case .symbol_lib: "SHT_MIPS_SYMBOL_LIB"
        case .events: "SHT_MIPS_EVENTS"
        case .translate: "SHT_MIPS_TRANSLATE"
        case .pixie: "SHT_MIPS_PIXIE"
        case .xlate: "SHT_MIPS_XLATE"
        case .xlate_debug: "SHT_MIPS_XLATE_DEBUG"
        case .whirl: "SHT_MIPS_WHIRL"
        case .eh_region: "SHT_MIPS_EH_REGION"
        case .xlate_old: "SHT_MIPS_XLATE_OLD"
        case .pdr_exception: "SHT_MIPS_PDR_EXCEPTION"
        case .abiflags: "SHT_MIPS_ABIFLAGS"
        }
    }
}

// MARK: - SPARC
extension SectionType {
    public enum SPARC: CaseIterable {
        /// SHT_SPARC_GOTDATA
        case gotdata
    }
}

extension SectionType.SPARC: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(SHT_SPARC_GOTDATA): self = .gotdata
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .gotdata: RawValue(SHT_SPARC_GOTDATA)
        }
    }
}

extension SectionType.SPARC: CustomStringConvertible {
    public var description: String {
        switch self {
        case .gotdata: "SHT_SPARC_GOTDATA"
        }
    }
}
