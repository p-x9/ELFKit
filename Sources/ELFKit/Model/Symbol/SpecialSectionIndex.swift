//
//  SpecialSectionIndex.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SpecialSectionIndex: CaseIterable {
    /// SHN_UNDEF
    case undef
    /// SHN_ABS
    case abs
    /// SHN_COMMON
    case common
    /// SHN_XINDEX
    case xindex
    /// SHN_BAD
    case bad
    /// SHN_PARISC_ANSI_COMMON
    case parisc_ansi_common
    /// SHN_PARISC_HUGE_COMMON
    case parisc_huge_common
    /// SHN_TLS_COMMON
    case tls_common
    /// SHN_NS_COMMON
    case ns_common
    /// SHN_FS_COMMON
    case fs_common
    /// SHN_NS_UNDEF
    case ns_undef
    /// SHN_FS_UNDEF
    case fs_undef
    /// SHN_HP_EXTERN
    case hp_extern
    /// SHN_HP_EXTHINT
    case hp_exthint
    /// SHN_HP_UNDEF_BIND_IMM
    case hp_undef_bind_imm
    /// SHN_IA_64_ANSI_COMMON
    case ia_64_ansi_common
    /// SHN_IA_64_VMS_SYMVEC
    case ia_64_vms_symvec
    /// SHN_M32R_SCOMMON
    case m32r_scommon
    /// SHN_MIPS_ACOMMON
    case mips_acommon
    /// SHN_MIPS_TEXT
    case mips_text
    /// SHN_MIPS_DATA
    case mips_data
    /// SHN_MIPS_SCOMMON
    case mips_scommon
    /// SHN_MIPS_SUNDEFINED
    case mips_sundefined
    /// SHN_REGISTER
    case register
    /// SHN_SCORE_TEXT
    case score_text
    /// SHN_SCORE_DATA
    case score_data
    /// SHN_SCORE_SCOMMON
    case score_scommon
    /// SHN_BEFORE
    case before
    /// SHN_AFTER
    case after
    /// SHN_TIC6X_SCOMMON
    case tic6x_scommon
    /// SHN_V850_SCOMMON
    case v850_scommon
    /// SHN_V850_TCOMMON
    case v850_tcommon
    /// SHN_V850_ZCOMMON
    case v850_zcommon
    /// SHN_X86_64_LCOMMON
    case x86_64_lcommon
}

extension SpecialSectionIndex/*: RawRepresentable*/ {
    public typealias RawValue = UInt64

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        switch rawValue {
        case 0: self = .undef
        case 0xfff1: self = .abs
        case 0xfff2: self = .common
        case 0xffff: self = .xindex
        case 0xfffffeff: self = .bad

        default:
            switch (osabi, machine, rawValue) {
            case (.hpux, .parisc, 0xff00): self = .parisc_ansi_common
            case (.hpux, .parisc, 0xff01): self = .parisc_huge_common

            case (.hpux, _, 0xff20): self = .tls_common
            case (.hpux, _, 0xff21): self = .ns_common
            case (.hpux, _, 0xff22): self = .fs_common
            case (.hpux, _, 0xff23): self = .ns_undef
            case (.hpux, _, 0xff24): self = .fs_undef
            case (.hpux, _, 0xff25): self = .hp_extern
            case (.hpux, _, 0xff26): self = .hp_exthint
            case (.hpux, _, 0xff27): self = .hp_undef_bind_imm

            case (.hpux, .ia_64, 0xff00): self = .ia_64_ansi_common
            case (.openvms, .ia_64, 0xff20): self = .ia_64_vms_symvec

            case (_, .m32r, 0xff00): self = .m32r_scommon
            case (_, .cygnus_m32r, 0xff00): self = .m32r_scommon

            case (_, .mips, 0xff00): self = .mips_acommon
            case (_, .mips, 0xff01): self = .mips_text
            case (_, .mips, 0xff02): self = .mips_data
            case (_, .mips, 0xff03): self = .mips_scommon
            case (_, .mips, 0xff04): self = .mips_sundefined

            case (_, .mmix, 0xff00): self = .register


            case (_, .score, 0xff01): self = .score_text
            case (_, .score, 0xff02): self = .score_data
            case (_, .score, 0xff03): self = .score_scommon

            case _ where [
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
                switch rawValue {
                case 0xff00: self = .before
                case 0xff01: self = .after
                default:
                    return nil
                }

            case (_, .ti_c6000, 0xff00): self = .tic6x_scommon

            case _ where [.v800, .v850, .cygnus_v850].contains(machine):
                switch rawValue {
                case 0xff00: self = .v850_scommon
                case 0xff01: self = .v850_tcommon
                case 0xff02: self = .v850_zcommon
                default:
                    return nil
                }

            case (_, _, 0xff02) where [.x86_64, .l10m, .k10m].contains(machine):
                self = .x86_64_lcommon

            default: return nil
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .undef: 0
        case .abs: 0xfff1
        case .common: 0xfff2
        case .xindex: 0xffff
        case .bad: 0xfffffeff
        case .parisc_ansi_common: 0xff00
        case .parisc_huge_common: 0xff01
        case .tls_common: 0xff20
        case .ns_common: 0xff21
        case .fs_common: 0xff22
        case .ns_undef: 0xff23
        case .fs_undef: 0xff24
        case .hp_extern: 0xff25
        case .hp_exthint: 0xff26
        case .hp_undef_bind_imm: 0xff27
        case .ia_64_ansi_common: 0xff00
        case .ia_64_vms_symvec: 0xff20
        case .m32r_scommon: 0xff00
        case .mips_acommon: 0xff00
        case .mips_text: 0xff01
        case .mips_data: 0xff02
        case .mips_scommon: 0xff03
        case .mips_sundefined: 0xff04
        case .register: 0xff00
        case .score_text: 0xff01
        case .score_data: 0xff02
        case .score_scommon: 0xff03
        case .before: 0xff00
        case .after: 0xff01
        case .tic6x_scommon: 0xff00
        case .v850_scommon: 0xff00
        case .v850_tcommon: 0xff01
        case .v850_zcommon: 0xff02
        case .x86_64_lcommon: 0xff02
        }
    }
}

extension SpecialSectionIndex: CustomStringConvertible {
    public var description: String {
        switch self {
        case .undef: "SHN_UNDEF"
        case .abs: "SHN_ABS"
        case .common: "SHN_COMMON"
        case .xindex: "SHN_XINDEX"
        case .bad: "SHN_BAD"
        case .parisc_ansi_common: "SHN_PARISC_ANSI_COMMON"
        case .parisc_huge_common: "SHN_PARISC_HUGE_COMMON"
        case .tls_common: "SHN_TLS_COMMON"
        case .ns_common: "SHN_NS_COMMON"
        case .fs_common: "SHN_FS_COMMON"
        case .ns_undef: "SHN_NS_UNDEF"
        case .fs_undef: "SHN_FS_UNDEF"
        case .hp_extern: "SHN_HP_EXTERN"
        case .hp_exthint: "SHN_HP_EXTHINT"
        case .hp_undef_bind_imm: "SHN_HP_UNDEF_BIND_IMM"
        case .ia_64_ansi_common: "SHN_IA_64_ANSI_COMMON"
        case .ia_64_vms_symvec: "SHN_IA_64_VMS_SYMVEC"
        case .m32r_scommon: "SHN_M32R_SCOMMON"
        case .mips_acommon: "SHN_MIPS_ACOMMON"
        case .mips_text: "SHN_MIPS_TEXT"
        case .mips_data: "SHN_MIPS_DATA"
        case .mips_scommon: "SHN_MIPS_SCOMMON"
        case .mips_sundefined: "SHN_MIPS_SUNDEFINED"
        case .register: "SHN_REGISTER"
        case .score_text: "SHN_SCORE_TEXT"
        case .score_data: "SHN_SCORE_DATA"
        case .score_scommon: "SHN_SCORE_SCOMMON"
        case .before: "SHN_BEFORE"
        case .after: "SHN_AFTER"
        case .tic6x_scommon: "SHN_TIC6X_SCOMMON"
        case .v850_scommon: "SHN_V850_SCOMMON"
        case .v850_tcommon: "SHN_V850_TCOMMON"
        case .v850_zcommon: "SHN_V850_ZCOMMON"
        case .x86_64_lcommon: "SHN_X86_64_LCOMMON"
        }
    }
}
