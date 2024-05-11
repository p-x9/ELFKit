//
//  SectionFlags.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
import ELFKitC

public struct SectionFlags: ConditionalBitFlags {
    public typealias RawValue = UInt64

    public var rawValue: RawValue
    public var _bits: Set<Bit>

    public init(rawValue: RawValue, _bits: Set<Bit>) {
        self.rawValue = rawValue
        self._bits = _bits
    }

    public init(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        self.rawValue = rawValue

        var bits: [Bit] = []
        var mask: RawValue = 1
        for _ in 0..<UInt.bitWidth {
            let bit = Bit(
                rawValue: rawValue & mask,
                osabi: osabi,
                machine: machine
            )
            if let bit {
                bits.append(bit)
            }
            mask <<= 1
        }

        self._bits = Set(bits)
    }
}

extension SectionFlags {
    public var isOSSpecific: Bool {
        let SHF_MASKOS = 0x0F000000
        return (rawValue & numericCast(SHF_MASKOS)) > 0
    }

    public var isProcessorSpecific: Bool {
        let SHF_MASKPROC = 0xF0000000
        return (rawValue & numericCast(SHF_MASKPROC)) > 0
    }
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
        /// SHF_ENTRYSECT
        case entrysect
        /// SHF_COMDEF
        case comdef
        /// SHF_ALPHA_GPREL
        case alpha_gprel
        /// SHF_ARM_PURECODE
        case arm_purecode
        /// SHF_GNU_RETAIN
        case gnu_retain
        /// SHF_EXCLUDE
        case exclude
        /// SHF_GNU_MBIND
        case gnu_mbind
        /// SHF_PARISC_SBP
        case parisc_sbp
        /// SHF_PARISC_HUGE
        case parisc_huge
        /// SHF_PARISC_SHORT
        case parisc_short
        /// SHF_PARISC_WEAKORDER
        case parisc_weakorder
        /// SHF_HP_TLS
        case hp_tls
        /// SHF_HP_NEAR_SHARED
        case hp_near_shared
        /// SHF_HP_FAR_SHARED
        case hp_far_shared
        /// SHF_HP_COMDAT
        case hp_comdat
        /// SHF_HP_CONST
        case hp_const
        /// SHF_IA_64_SHORT
        case ia_64_short
        /// SHF_IA_64_NORECOV
        case ia_64_norecov
        /// SHF_IA_64_HP_TLS
        case ia_64_hp_tls
        /// SHF_IA_64_VMS_GLOBAL
        case ia_64_vms_global
        /// SHF_IA_64_VMS_OVERLAID
        case ia_64_vms_overlaid
        /// SHF_IA_64_VMS_SHARED
        case ia_64_vms_shared
        /// SHF_IA_64_VMS_VECTOR
        case ia_64_vms_vector
        /// SHF_IA_64_VMS_ALLOC_64BIT
        case ia_64_vms_alloc_64bit
        /// SHF_IA_64_VMS_PROTECTED
        case ia_64_vms_protected
        /// SHF_M32R_CAN_RELAX
        case m32r_can_relax
        /// SHF_MCORE_NOREAD
        case mcore_noread
        /// SHF_MEP_VLIW
        case mep_vliw
        /// SHF_MICROBLAZE_NOREAD
        case microblaze_noread
        /// SHF_MIPS_GPREL
        case mips_gprel
        /// SHF_MIPS_MERGE
        case mips_merge
        /// SHF_MIPS_ADDR
        case mips_addr
        /// SHF_MIPS_STRING
        case mips_string
        /// SHF_MIPS_NOSTRIP
        case mips_nostrip
        /// SHF_MIPS_LOCAL
        case mips_local
        /// SHF_MIPS_NAMES
        case mips_names
        /// SHF_MIPS_NODUPES
        case mips_nodupes
        /// SHF_MMIX_CANRELAX
        case mmix_canrelax
        /// SHF_NFP_INIT
        case nfp_init
        /// SHF_NFP_INIT2
        case nfp_init2
        /// SHF_NIOS2_GPREL
        case nios2_gprel
        /// SHF_PPC_VLE
        case ppc_vle
        /// SHF_SCORE_GPREL
        case score_gprel
        /// SHF_SCORE_MERGE
        case score_merge
        /// SHF_SCORE_ADDR
        case score_addr
        /// SHF_SCORE_STRING
        case score_string
        /// SHF_SCORE_NOSTRIP
        case score_nostrip
        /// SHF_SCORE_LOCAL
        case score_local
        /// SHF_SCORE_NAMES
        case score_names
        /// SHF_SCORE_NODUPES
        case score_nodupes
        /// SHF_ORDERED
        case ordered
        /// SHF_V850_GPREL
        case v850_gprel
        /// SHF_V850_EPREL
        case v850_eprel
        /// SHF_V850_R0REL
        case v850_r0rel
        /// SHF_RENESAS_ABS
        case renesas_abs
        /// SHF_GHS_ABS
        case ghs_abs
        /// SHF_X86_64_LARGE
        case x86_64_large
    }
}

extension SectionFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        self.init(
            rawValue: rawValue,
            osabi: .none,
            machine: .none
        )
    }

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        switch rawValue {
        case 1: self = .write
        case 2: self = .alloc
        case 4: self = .execinstr
        case 16: self = .merge
        case 32: self = .strings
        case 64: self = .info_link
        case 128: self = .link_order
        case 0x100: self = .os_nonconforming
        case 0x200: self = .group
        case 0x400: self = .tls
        case 0x800: self = .compressed

        default:
            switch (osabi, machine, rawValue) {
            case (_, .ia_64, 0x10000000): self = .ia_64_short
            case (_, .ia_64, 0x20000000): self = .ia_64_norecov
            case (_, .ia_64, 0x1000000): self = .ia_64_hp_tls

            case (.openvms, .ia_64, 0x100000000): self = .ia_64_vms_global
            case (.openvms, .ia_64, 0x200000000): self = .ia_64_vms_overlaid
            case (.openvms, .ia_64, 0x400000000): self = .ia_64_vms_shared
            case (.openvms, .ia_64, 0x800000000): self = .ia_64_vms_vector
            case (.openvms, .ia_64, 0x1000000000): self = .ia_64_vms_alloc_64bit
            case (.openvms, .ia_64, 0x2000000000): self = .ia_64_vms_protected

            case (_, _, 0x40000000) where [
                ._386,
                .iamcu,
                .x86_64,
                .l10m,
                .k10m,
                .old_sparcv9,
                .sparc32plus,
                .sparcv9,
                .sparc
            ].contains(
                machine
            ):
                self = .ordered

            case (_, .arm, 0x10000000): self = .entrysect
            case (_, .arm, 0x20000000): self = .arm_purecode
            case (_, .arm, 0x80000000): self = .comdef

            case (_, .aarch64, 0x10000000): self = .entrysect
            case (_, .aarch64, 0x80000000): self = .comdef

            case (_, .ppc, 0x10000000): self = .ppc_vle

            case (_, _, 0x200000) where [.linux, .freebsd].contains(osabi):
                self = .gnu_retain

            case (.none, _, 0x1000000): self = .gnu_mbind

            case (_, .score, 0x10000000): self = .score_gprel
            case (_, .score, 0x20000000): self = .score_merge
            case (_, .score, 0x40000000): self = .score_addr
            case (_, .score, 0x80000000): self = .score_string
            case (_, .score, 0x8000000): self = .score_nostrip
            case (_, .score, 0x4000000): self = .score_local
            case (_, .score, 0x2000000): self = .score_names
            case (_, .score, 0x1000000): self = .score_nodupes

            case (_, .mips, 0x10000000): self = .mips_gprel
            case (_, .mips, 0x20000000): self = .mips_merge
            case (_, .mips, 0x40000000): self = .mips_addr
            case (_, .mips, 0x80000000): self = .mips_string
            case (_, .mips, 0x8000000): self = .mips_nostrip
            case (_, .mips, 0x4000000): self = .mips_local
            case (_, .mips, 0x2000000): self = .mips_names
            case (_, .mips, 0x1000000): self = .mips_nodupes

            case (_, .parisc, 0x80000000): self = .parisc_sbp
            case (_, .parisc, 0x40000000): self = .parisc_huge
            case (_, .parisc, 0x20000000): self = .parisc_short
            case (_, .parisc, 0x10000000): self = .parisc_weakorder

            case (_, _, 0x10000000) where [.alpha, .old_alpha].contains(machine):
                self = .alpha_gprel

            case (.hpux, _, 0x1000000): self = .hp_tls
            case (.hpux, _, 0x2000000): self = .hp_near_shared
            case (.hpux, _, 0x4000000): self = .hp_far_shared
            case (.hpux, _, 0x8000000): self = .hp_comdat
            case (.hpux, _, 0x800000): self = .hp_const

            case (_, _, 0x10000000) where [.m32r, .cygnus_m32r].contains(machine):
                self = .m32r_can_relax

            case (_, .nfp, 0x80000000): self = .nfp_init
            case (_, .nfp, 0x40000000): self = .nfp_init2

            case (_, .altera_nios2, 0x10000000): self = .nios2_gprel

            case (_, .mcore, 0x80000000): self = .mcore_noread

            case (_, .cygnus_mep, 0x10000000): self = .mep_vliw

            case (_, .mmix, 0x80000000): self = .mmix_canrelax

            case (_, _, 0x80000000) where [.microblaze, .microblaze_old].contains(machine):
                self = .microblaze_noread

            case (_, .x86_64, 0x10000000): self = .x86_64_large

            case _ where [.v800, .v850, .cygnus_v850].contains(machine):
                switch rawValue {
                case 0x10000000: self = .v850_gprel
                case 0x20000000: self = .v850_eprel
                case 0x40000000: self = .v850_r0rel
                case 0x80000000: self = .renesas_abs
                case 0x400: self = .ghs_abs
                default:
                    return nil
                }

            case (_, _, 0x80000000): self = .exclude

            default: return nil
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .write: 1
        case .alloc: 2
        case .execinstr: 4
        case .merge: 16
        case .strings: 32
        case .info_link: 64
        case .link_order: 128
        case .os_nonconforming: 0x100
        case .group: 0x200
        case .tls: 0x400
        case .compressed: 0x800
        case .entrysect: 0x10000000
        case .comdef: 0x80000000
        case .alpha_gprel: 0x10000000
        case .arm_purecode: 0x20000000
        case .gnu_retain: 0x200000
        case .exclude: 0x80000000
        case .gnu_mbind: 0x1000000
        case .parisc_sbp: 0x80000000
        case .parisc_huge: 0x40000000
        case .parisc_short: 0x20000000
        case .parisc_weakorder: 0x10000000
        case .hp_tls: 0x1000000
        case .hp_near_shared: 0x2000000
        case .hp_far_shared: 0x4000000
        case .hp_comdat: 0x8000000
        case .hp_const: 0x800000
        case .ia_64_short: 0x10000000
        case .ia_64_norecov: 0x20000000
        case .ia_64_hp_tls: 0x1000000
        case .ia_64_vms_global: 0x100000000
        case .ia_64_vms_overlaid: 0x200000000
        case .ia_64_vms_shared: 0x400000000
        case .ia_64_vms_vector: 0x800000000
        case .ia_64_vms_alloc_64bit: 0x1000000000
        case .ia_64_vms_protected: 0x2000000000
        case .m32r_can_relax: 0x10000000
        case .mcore_noread: 0x80000000
        case .mep_vliw: 0x10000000
        case .microblaze_noread: 0x80000000
        case .mips_gprel: 0x10000000
        case .mips_merge: 0x20000000
        case .mips_addr: 0x40000000
        case .mips_string: 0x80000000
        case .mips_nostrip: 0x8000000
        case .mips_local: 0x4000000
        case .mips_names: 0x2000000
        case .mips_nodupes: 0x1000000
        case .mmix_canrelax: 0x80000000
        case .nfp_init: 0x80000000
        case .nfp_init2: 0x40000000
        case .nios2_gprel: 0x10000000
        case .ppc_vle: 0x10000000
        case .score_gprel: 0x10000000
        case .score_merge: 0x20000000
        case .score_addr: 0x40000000
        case .score_string: 0x80000000
        case .score_nostrip: 0x8000000
        case .score_local: 0x4000000
        case .score_names: 0x2000000
        case .score_nodupes: 0x1000000
        case .ordered: 0x40000000
        case .v850_gprel: 0x10000000
        case .v850_eprel: 0x20000000
        case .v850_r0rel: 0x40000000
        case .renesas_abs: 0x80000000
        case .ghs_abs: 0x400
        case .x86_64_large: 0x10000000
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
        case .entrysect: "SHF_ENTRYSECT"
        case .comdef: "SHF_COMDEF"
        case .alpha_gprel: "SHF_ALPHA_GPREL"
        case .arm_purecode: "SHF_ARM_PURECODE"
        case .gnu_retain: "SHF_GNU_RETAIN"
        case .exclude: "SHF_EXCLUDE"
        case .gnu_mbind: "SHF_GNU_MBIND"
        case .parisc_sbp: "SHF_PARISC_SBP"
        case .parisc_huge: "SHF_PARISC_HUGE"
        case .parisc_short: "SHF_PARISC_SHORT"
        case .parisc_weakorder: "SHF_PARISC_WEAKORDER"
        case .hp_tls: "SHF_HP_TLS"
        case .hp_near_shared: "SHF_HP_NEAR_SHARED"
        case .hp_far_shared: "SHF_HP_FAR_SHARED"
        case .hp_comdat: "SHF_HP_COMDAT"
        case .hp_const: "SHF_HP_CONST"
        case .ia_64_short: "SHF_IA_64_SHORT"
        case .ia_64_norecov: "SHF_IA_64_NORECOV"
        case .ia_64_hp_tls: "SHF_IA_64_HP_TLS"
        case .ia_64_vms_global: "SHF_IA_64_VMS_GLOBAL"
        case .ia_64_vms_overlaid: "SHF_IA_64_VMS_OVERLAID"
        case .ia_64_vms_shared: "SHF_IA_64_VMS_SHARED"
        case .ia_64_vms_vector: "SHF_IA_64_VMS_VECTOR"
        case .ia_64_vms_alloc_64bit: "SHF_IA_64_VMS_ALLOC_64BIT"
        case .ia_64_vms_protected: "SHF_IA_64_VMS_PROTECTED"
        case .m32r_can_relax: "SHF_M32R_CAN_RELAX"
        case .mcore_noread: "SHF_MCORE_NOREAD"
        case .mep_vliw: "SHF_MEP_VLIW"
        case .microblaze_noread: "SHF_MICROBLAZE_NOREAD"
        case .mips_gprel: "SHF_MIPS_GPREL"
        case .mips_merge: "SHF_MIPS_MERGE"
        case .mips_addr: "SHF_MIPS_ADDR"
        case .mips_string: "SHF_MIPS_STRING"
        case .mips_nostrip: "SHF_MIPS_NOSTRIP"
        case .mips_local: "SHF_MIPS_LOCAL"
        case .mips_names: "SHF_MIPS_NAMES"
        case .mips_nodupes: "SHF_MIPS_NODUPES"
        case .mmix_canrelax: "SHF_MMIX_CANRELAX"
        case .nfp_init: "SHF_NFP_INIT"
        case .nfp_init2: "SHF_NFP_INIT2"
        case .nios2_gprel: "SHF_NIOS2_GPREL"
        case .ppc_vle: "SHF_PPC_VLE"
        case .score_gprel: "SHF_SCORE_GPREL"
        case .score_merge: "SHF_SCORE_MERGE"
        case .score_addr: "SHF_SCORE_ADDR"
        case .score_string: "SHF_SCORE_STRING"
        case .score_nostrip: "SHF_SCORE_NOSTRIP"
        case .score_local: "SHF_SCORE_LOCAL"
        case .score_names: "SHF_SCORE_NAMES"
        case .score_nodupes: "SHF_SCORE_NODUPES"
        case .ordered: "SHF_ORDERED"
        case .v850_gprel: "SHF_V850_GPREL"
        case .v850_eprel: "SHF_V850_EPREL"
        case .v850_r0rel: "SHF_V850_R0REL"
        case .renesas_abs: "SHF_RENESAS_ABS"
        case .ghs_abs: "SHF_GHS_ABS"
        case .x86_64_large: "SHF_X86_64_LARGE"
        }
    }
}
