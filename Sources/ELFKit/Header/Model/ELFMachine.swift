//
//  ELFMachine.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
import ELFKitC

public enum ELFMachine: CaseIterable {
    /// EM_NONE
    case none
    /// EM_M32
    case m32
    /// EM_SPARC
    case sparc
    /// EM_386
    case _386
    /// EM_68K
    case _68k
    /// EM_88K
    case _88k
    /// EM_IAMCU
    case iamcu
    /// EM_860
    case _860
    /// EM_MIPS
    case mips
    /// EM_S370
    case s370
    /// EM_MIPS_RS3_LE
    case mips_rs3_le
    /// EM_PARISC
    case parisc
    /// EM_VPP500
    case vpp500
    /// EM_SPARC32PLUS
    case sparc32plus
    /// EM_960
    case _960
    /// EM_PPC
    case ppc
    /// EM_PPC64
    case ppc64
    /// EM_S390
    case s390
    /// EM_V800
    case v800
    /// EM_FR20
    case fr20
    /// EM_RH32
    case rh32
    /// EM_RCE
    case rce
    /// EM_ARM
    case arm
    /// EM_SH
    case sh
    /// EM_SPARCV9
    case sparcv9
    /// EM_TRICORE
    case tricore
    /// EM_ARC
    case arc
    /// EM_H8_300
    case h8_300
    /// EM_H8_300H
    case h8_300h
    /// EM_H8S
    case h8s
    /// EM_H8_500
    case h8_500
    /// EM_IA_64
    case ia_64
    /// EM_MIPS_X
    case mips_x
    /// EM_COLDFIRE
    case coldfire
    /// EM_68HC12
    case _68hc12
    /// EM_MMA
    case mma
    /// EM_PCP
    case pcp
    /// EM_NCPU
    case ncpu
    /// EM_NDR1
    case ndr1
    /// EM_STARCORE
    case starcore
    /// EM_ME16
    case me16
    /// EM_ST100
    case st100
    /// EM_TINYJ
    case tinyj
    /// EM_X86_64
    case x86_64
    /// EM_AMD64
    case amd64
    /// EM_PDSP
    case pdsp
    /// EM_FX66
    case fx66
    /// EM_ST9PLUS
    case st9plus
    /// EM_ST7
    case st7
    /// EM_68HC16
    case _68hc16
    /// EM_68HC11
    case _68hc11
    /// EM_68HC08
    case _68hc08
    /// EM_68HC05
    case _68hc05
    /// EM_SVX
    case svx
    /// EM_ST19
    case st19
    /// EM_VAX
    case vax
    /// EM_CRIS
    case cris
    /// EM_JAVELIN
    case javelin
    /// EM_FIREPATH
    case firepath
    /// EM_ZSP
    case zsp
    /// EM_MMIX
    case mmix
    /// EM_HUANY
    case huany
    /// EM_PRISM
    case prism
    /// EM_AVR
    case avr
    /// EM_FR30
    case fr30
    /// EM_D10V
    case d10v
    /// EM_D30V
    case d30v
    /// EM_V850
    case v850
    /// EM_M32R
    case m32r
    /// EM_MN10300
    case mn10300
    /// EM_MN10200
    case mn10200
    /// EM_PJ
    case pj
    /// EM_OPENRISC
    case openrisc
    /// EM_ARC_A5
    case arc_a5
    /// EM_XTENSA
    case xtensa
    /// EM_VIDEOCORE
    case videocore
    /// EM_TMM_GPP
    case tmm_gpp
    /// EM_NS32K
    case ns32k
    /// EM_TPC
    case tpc
    /// EM_SNP1K
    case snp1k
    /// EM_ST200
    case st200
    /// EM_IP2K
    case ip2k
    /// EM_MAX
    case max
    /// EM_CR
    case cr
    /// EM_F2MC16
    case f2mc16
    /// EM_MSP430
    case msp430
    /// EM_BLACKFIN
    case blackfin
    /// EM_SE_C33
    case se_c33
    /// EM_SEP
    case sep
    /// EM_ARCA
    case arca
    /// EM_UNICORE
    case unicore
    /// EM_AARCH64
    case aarch64
    /// EM_RISCV
    case riscv
    /// EM_486
    case _486
    /// EM_MIPS_RS4_BE
    case mips_rs4_be
    /// EM_ALPHA_STD
    case alpha_std
    /// EM_ALPHA
    case alpha
}

extension ELFMachine: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(EM_NONE): self = .none
        case RawValue(EM_M32): self = .m32
        case RawValue(EM_SPARC): self = .sparc
        case RawValue(EM_386): self = ._386
        case RawValue(EM_68K): self = ._68k
        case RawValue(EM_88K): self = ._88k
        case RawValue(EM_IAMCU): self = .iamcu
        case RawValue(EM_860): self = ._860
        case RawValue(EM_MIPS): self = .mips
        case RawValue(EM_S370): self = .s370
        case RawValue(EM_MIPS_RS3_LE): self = .mips_rs3_le
        case RawValue(EM_PARISC): self = .parisc
        case RawValue(EM_VPP500): self = .vpp500
        case RawValue(EM_SPARC32PLUS): self = .sparc32plus
        case RawValue(EM_960): self = ._960
        case RawValue(EM_PPC): self = .ppc
        case RawValue(EM_PPC64): self = .ppc64
        case RawValue(EM_S390): self = .s390
        case RawValue(EM_V800): self = .v800
        case RawValue(EM_FR20): self = .fr20
        case RawValue(EM_RH32): self = .rh32
        case RawValue(EM_RCE): self = .rce
        case RawValue(EM_ARM): self = .arm
        case RawValue(EM_SH): self = .sh
        case RawValue(EM_SPARCV9): self = .sparcv9
        case RawValue(EM_TRICORE): self = .tricore
        case RawValue(EM_ARC): self = .arc
        case RawValue(EM_H8_300): self = .h8_300
        case RawValue(EM_H8_300H): self = .h8_300h
        case RawValue(EM_H8S): self = .h8s
        case RawValue(EM_H8_500): self = .h8_500
        case RawValue(EM_IA_64): self = .ia_64
        case RawValue(EM_MIPS_X): self = .mips_x
        case RawValue(EM_COLDFIRE): self = .coldfire
        case RawValue(EM_68HC12): self = ._68hc12
        case RawValue(EM_MMA): self = .mma
        case RawValue(EM_PCP): self = .pcp
        case RawValue(EM_NCPU): self = .ncpu
        case RawValue(EM_NDR1): self = .ndr1
        case RawValue(EM_STARCORE): self = .starcore
        case RawValue(EM_ME16): self = .me16
        case RawValue(EM_ST100): self = .st100
        case RawValue(EM_TINYJ): self = .tinyj
        case RawValue(EM_X86_64): self = .x86_64
        case RawValue(EM_AMD64): self = .amd64
        case RawValue(EM_PDSP): self = .pdsp
        case RawValue(EM_FX66): self = .fx66
        case RawValue(EM_ST9PLUS): self = .st9plus
        case RawValue(EM_ST7): self = .st7
        case RawValue(EM_68HC16): self = ._68hc16
        case RawValue(EM_68HC11): self = ._68hc11
        case RawValue(EM_68HC08): self = ._68hc08
        case RawValue(EM_68HC05): self = ._68hc05
        case RawValue(EM_SVX): self = .svx
        case RawValue(EM_ST19): self = .st19
        case RawValue(EM_VAX): self = .vax
        case RawValue(EM_CRIS): self = .cris
        case RawValue(EM_JAVELIN): self = .javelin
        case RawValue(EM_FIREPATH): self = .firepath
        case RawValue(EM_ZSP): self = .zsp
        case RawValue(EM_MMIX): self = .mmix
        case RawValue(EM_HUANY): self = .huany
        case RawValue(EM_PRISM): self = .prism
        case RawValue(EM_AVR): self = .avr
        case RawValue(EM_FR30): self = .fr30
        case RawValue(EM_D10V): self = .d10v
        case RawValue(EM_D30V): self = .d30v
        case RawValue(EM_V850): self = .v850
        case RawValue(EM_M32R): self = .m32r
        case RawValue(EM_MN10300): self = .mn10300
        case RawValue(EM_MN10200): self = .mn10200
        case RawValue(EM_PJ): self = .pj
        case RawValue(EM_OPENRISC): self = .openrisc
        case RawValue(EM_ARC_A5): self = .arc_a5
        case RawValue(EM_XTENSA): self = .xtensa
        case RawValue(EM_VIDEOCORE): self = .videocore
        case RawValue(EM_TMM_GPP): self = .tmm_gpp
        case RawValue(EM_NS32K): self = .ns32k
        case RawValue(EM_TPC): self = .tpc
        case RawValue(EM_SNP1K): self = .snp1k
        case RawValue(EM_ST200): self = .st200
        case RawValue(EM_IP2K): self = .ip2k
        case RawValue(EM_MAX): self = .max
        case RawValue(EM_CR): self = .cr
        case RawValue(EM_F2MC16): self = .f2mc16
        case RawValue(EM_MSP430): self = .msp430
        case RawValue(EM_BLACKFIN): self = .blackfin
        case RawValue(EM_SE_C33): self = .se_c33
        case RawValue(EM_SEP): self = .sep
        case RawValue(EM_ARCA): self = .arca
        case RawValue(EM_UNICORE): self = .unicore
        case RawValue(EM_AARCH64): self = .aarch64
        case RawValue(EM_RISCV): self = .riscv
        case RawValue(EM_486): self = ._486
        case RawValue(EM_MIPS_RS4_BE): self = .mips_rs4_be
        case RawValue(EM_ALPHA_STD): self = .alpha_std
        case RawValue(EM_ALPHA): self = .alpha
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .none: RawValue(EM_NONE)
        case .m32: RawValue(EM_M32)
        case .sparc: RawValue(EM_SPARC)
        case ._386: RawValue(EM_386)
        case ._68k: RawValue(EM_68K)
        case ._88k: RawValue(EM_88K)
        case .iamcu: RawValue(EM_IAMCU)
        case ._860: RawValue(EM_860)
        case .mips: RawValue(EM_MIPS)
        case .s370: RawValue(EM_S370)
        case .mips_rs3_le: RawValue(EM_MIPS_RS3_LE)
        case .parisc: RawValue(EM_PARISC)
        case .vpp500: RawValue(EM_VPP500)
        case .sparc32plus: RawValue(EM_SPARC32PLUS)
        case ._960: RawValue(EM_960)
        case .ppc: RawValue(EM_PPC)
        case .ppc64: RawValue(EM_PPC64)
        case .s390: RawValue(EM_S390)
        case .v800: RawValue(EM_V800)
        case .fr20: RawValue(EM_FR20)
        case .rh32: RawValue(EM_RH32)
        case .rce: RawValue(EM_RCE)
        case .arm: RawValue(EM_ARM)
        case .sh: RawValue(EM_SH)
        case .sparcv9: RawValue(EM_SPARCV9)
        case .tricore: RawValue(EM_TRICORE)
        case .arc: RawValue(EM_ARC)
        case .h8_300: RawValue(EM_H8_300)
        case .h8_300h: RawValue(EM_H8_300H)
        case .h8s: RawValue(EM_H8S)
        case .h8_500: RawValue(EM_H8_500)
        case .ia_64: RawValue(EM_IA_64)
        case .mips_x: RawValue(EM_MIPS_X)
        case .coldfire: RawValue(EM_COLDFIRE)
        case ._68hc12: RawValue(EM_68HC12)
        case .mma: RawValue(EM_MMA)
        case .pcp: RawValue(EM_PCP)
        case .ncpu: RawValue(EM_NCPU)
        case .ndr1: RawValue(EM_NDR1)
        case .starcore: RawValue(EM_STARCORE)
        case .me16: RawValue(EM_ME16)
        case .st100: RawValue(EM_ST100)
        case .tinyj: RawValue(EM_TINYJ)
        case .x86_64: RawValue(EM_X86_64)
        case .amd64: RawValue(EM_AMD64)
        case .pdsp: RawValue(EM_PDSP)
        case .fx66: RawValue(EM_FX66)
        case .st9plus: RawValue(EM_ST9PLUS)
        case .st7: RawValue(EM_ST7)
        case ._68hc16: RawValue(EM_68HC16)
        case ._68hc11: RawValue(EM_68HC11)
        case ._68hc08: RawValue(EM_68HC08)
        case ._68hc05: RawValue(EM_68HC05)
        case .svx: RawValue(EM_SVX)
        case .st19: RawValue(EM_ST19)
        case .vax: RawValue(EM_VAX)
        case .cris: RawValue(EM_CRIS)
        case .javelin: RawValue(EM_JAVELIN)
        case .firepath: RawValue(EM_FIREPATH)
        case .zsp: RawValue(EM_ZSP)
        case .mmix: RawValue(EM_MMIX)
        case .huany: RawValue(EM_HUANY)
        case .prism: RawValue(EM_PRISM)
        case .avr: RawValue(EM_AVR)
        case .fr30: RawValue(EM_FR30)
        case .d10v: RawValue(EM_D10V)
        case .d30v: RawValue(EM_D30V)
        case .v850: RawValue(EM_V850)
        case .m32r: RawValue(EM_M32R)
        case .mn10300: RawValue(EM_MN10300)
        case .mn10200: RawValue(EM_MN10200)
        case .pj: RawValue(EM_PJ)
        case .openrisc: RawValue(EM_OPENRISC)
        case .arc_a5: RawValue(EM_ARC_A5)
        case .xtensa: RawValue(EM_XTENSA)
        case .videocore: RawValue(EM_VIDEOCORE)
        case .tmm_gpp: RawValue(EM_TMM_GPP)
        case .ns32k: RawValue(EM_NS32K)
        case .tpc: RawValue(EM_TPC)
        case .snp1k: RawValue(EM_SNP1K)
        case .st200: RawValue(EM_ST200)
        case .ip2k: RawValue(EM_IP2K)
        case .max: RawValue(EM_MAX)
        case .cr: RawValue(EM_CR)
        case .f2mc16: RawValue(EM_F2MC16)
        case .msp430: RawValue(EM_MSP430)
        case .blackfin: RawValue(EM_BLACKFIN)
        case .se_c33: RawValue(EM_SE_C33)
        case .sep: RawValue(EM_SEP)
        case .arca: RawValue(EM_ARCA)
        case .unicore: RawValue(EM_UNICORE)
        case .aarch64: RawValue(EM_AARCH64)
        case .riscv: RawValue(EM_RISCV)
        case ._486: RawValue(EM_486)
        case .mips_rs4_be: RawValue(EM_MIPS_RS4_BE)
        case .alpha_std: RawValue(EM_ALPHA_STD)
        case .alpha: RawValue(EM_ALPHA)
        }
    }
}

extension ELFMachine: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "EM_NONE"
        case .m32: "EM_M32"
        case .sparc: "EM_SPARC"
        case ._386: "EM_386"
        case ._68k: "EM_68K"
        case ._88k: "EM_88K"
        case .iamcu: "EM_IAMCU"
        case ._860: "EM_860"
        case .mips: "EM_MIPS"
        case .s370: "EM_S370"
        case .mips_rs3_le: "EM_MIPS_RS3_LE"
        case .parisc: "EM_PARISC"
        case .vpp500: "EM_VPP500"
        case .sparc32plus: "EM_SPARC32PLUS"
        case ._960: "EM_960"
        case .ppc: "EM_PPC"
        case .ppc64: "EM_PPC64"
        case .s390: "EM_S390"
        case .v800: "EM_V800"
        case .fr20: "EM_FR20"
        case .rh32: "EM_RH32"
        case .rce: "EM_RCE"
        case .arm: "EM_ARM"
        case .sh: "EM_SH"
        case .sparcv9: "EM_SPARCV9"
        case .tricore: "EM_TRICORE"
        case .arc: "EM_ARC"
        case .h8_300: "EM_H8_300"
        case .h8_300h: "EM_H8_300H"
        case .h8s: "EM_H8S"
        case .h8_500: "EM_H8_500"
        case .ia_64: "EM_IA_64"
        case .mips_x: "EM_MIPS_X"
        case .coldfire: "EM_COLDFIRE"
        case ._68hc12: "EM_68HC12"
        case .mma: "EM_MMA"
        case .pcp: "EM_PCP"
        case .ncpu: "EM_NCPU"
        case .ndr1: "EM_NDR1"
        case .starcore: "EM_STARCORE"
        case .me16: "EM_ME16"
        case .st100: "EM_ST100"
        case .tinyj: "EM_TINYJ"
        case .x86_64: "EM_X86_64"
        case .amd64: "EM_AMD64"
        case .pdsp: "EM_PDSP"
        case .fx66: "EM_FX66"
        case .st9plus: "EM_ST9PLUS"
        case .st7: "EM_ST7"
        case ._68hc16: "EM_68HC16"
        case ._68hc11: "EM_68HC11"
        case ._68hc08: "EM_68HC08"
        case ._68hc05: "EM_68HC05"
        case .svx: "EM_SVX"
        case .st19: "EM_ST19"
        case .vax: "EM_VAX"
        case .cris: "EM_CRIS"
        case .javelin: "EM_JAVELIN"
        case .firepath: "EM_FIREPATH"
        case .zsp: "EM_ZSP"
        case .mmix: "EM_MMIX"
        case .huany: "EM_HUANY"
        case .prism: "EM_PRISM"
        case .avr: "EM_AVR"
        case .fr30: "EM_FR30"
        case .d10v: "EM_D10V"
        case .d30v: "EM_D30V"
        case .v850: "EM_V850"
        case .m32r: "EM_M32R"
        case .mn10300: "EM_MN10300"
        case .mn10200: "EM_MN10200"
        case .pj: "EM_PJ"
        case .openrisc: "EM_OPENRISC"
        case .arc_a5: "EM_ARC_A5"
        case .xtensa: "EM_XTENSA"
        case .videocore: "EM_VIDEOCORE"
        case .tmm_gpp: "EM_TMM_GPP"
        case .ns32k: "EM_NS32K"
        case .tpc: "EM_TPC"
        case .snp1k: "EM_SNP1K"
        case .st200: "EM_ST200"
        case .ip2k: "EM_IP2K"
        case .max: "EM_MAX"
        case .cr: "EM_CR"
        case .f2mc16: "EM_F2MC16"
        case .msp430: "EM_MSP430"
        case .blackfin: "EM_BLACKFIN"
        case .se_c33: "EM_SE_C33"
        case .sep: "EM_SEP"
        case .arca: "EM_ARCA"
        case .unicore: "EM_UNICORE"
        case .aarch64: "EM_AARCH64"
        case .riscv: "EM_RISCV"
        case ._486: "EM_486"
        case .mips_rs4_be: "EM_MIPS_RS4_BE"
        case .alpha_std: "EM_ALPHA_STD"
        case .alpha: "EM_ALPHA"
        }
    }
}
