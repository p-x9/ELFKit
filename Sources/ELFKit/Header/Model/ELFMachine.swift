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
    /// EM_486
    case _486
    /// EM_860
    case _860
    /// EM_MIPS
    case mips
    /// EM_MIPS_RS3_LE
    case mips_rs3_le
    /// EM_MIPS_RS4_BE
    case mips_rs4_be
    /// EM_PARISC
    case parisc
    /// EM_SPARC32PLUS
    case sparc32plus
    /// EM_PPC
    case ppc
    /// EM_PPC64
    case ppc64
    /// EM_SPU
    case spu
    /// EM_ARM
    case arm
    /// EM_SH
    case sh
    /// EM_SPARCV9
    case sparcv9
    /// EM_H8_300
    case h8_300
    /// EM_IA_64
    case ia_64
    /// EM_X86_64
    case x86_64
    /// EM_S390
    case s390
    /// EM_CRIS
    case cris
    /// EM_M32R
    case m32r
    /// EM_MN10300
    case mn10300
    /// EM_OPENRISC
    case openrisc
    /// EM_ARCOMPACT
    case arcompact
    /// EM_XTENSA
    case xtensa
    /// EM_BLACKFIN
    case blackfin
    /// EM_UNICORE
    case unicore
    /// EM_ALTERA_NIOS2
    case altera_nios2
    /// EM_TI_C6000
    case ti_c6000
    /// EM_HEXAGON
    case hexagon
    /// EM_NDS32
    case nds32
    /// EM_AARCH64
    case aarch64
    /// EM_TILEPRO
    case tilepro
    /// EM_MICROBLAZE
    case microblaze
    /// EM_TILEGX
    case tilegx
    /// EM_ARCV2
    case arcv2
    /// EM_RISCV
    case riscv
    /// EM_BPF
    case bpf
    /// EM_CSKY
    case csky
    /// EM_LOONGARCH
    case loongarch
    /// EM_FRV
    case frv
    /// EM_ALPHA
    case alpha
    /// EM_CYGNUS_M32R
    case cygnus_m32r
    /// EM_S390_OLD
    case s390_old
    /// EM_CYGNUS_MN10300
    case cygnus_mn10300
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
        case RawValue(EM_486): self = ._486
        case RawValue(EM_860): self = ._860
        case RawValue(EM_MIPS): self = .mips
        case RawValue(EM_MIPS_RS3_LE): self = .mips_rs3_le
        case RawValue(EM_MIPS_RS4_BE): self = .mips_rs4_be
        case RawValue(EM_PARISC): self = .parisc
        case RawValue(EM_SPARC32PLUS): self = .sparc32plus
        case RawValue(EM_PPC): self = .ppc
        case RawValue(EM_PPC64): self = .ppc64
        case RawValue(EM_SPU): self = .spu
        case RawValue(EM_ARM): self = .arm
        case RawValue(EM_SH): self = .sh
        case RawValue(EM_SPARCV9): self = .sparcv9
        case RawValue(EM_H8_300): self = .h8_300
        case RawValue(EM_IA_64): self = .ia_64
        case RawValue(EM_X86_64): self = .x86_64
        case RawValue(EM_S390): self = .s390
        case RawValue(EM_CRIS): self = .cris
        case RawValue(EM_M32R): self = .m32r
        case RawValue(EM_MN10300): self = .mn10300
        case RawValue(EM_OPENRISC): self = .openrisc
        case RawValue(EM_ARCOMPACT): self = .arcompact
        case RawValue(EM_XTENSA): self = .xtensa
        case RawValue(EM_BLACKFIN): self = .blackfin
        case RawValue(EM_UNICORE): self = .unicore
        case RawValue(EM_ALTERA_NIOS2): self = .altera_nios2
        case RawValue(EM_TI_C6000): self = .ti_c6000
        case RawValue(EM_HEXAGON): self = .hexagon
        case RawValue(EM_NDS32): self = .nds32
        case RawValue(EM_AARCH64): self = .aarch64
        case RawValue(EM_TILEPRO): self = .tilepro
        case RawValue(EM_MICROBLAZE): self = .microblaze
        case RawValue(EM_TILEGX): self = .tilegx
        case RawValue(EM_ARCV2): self = .arcv2
        case RawValue(EM_RISCV): self = .riscv
        case RawValue(EM_BPF): self = .bpf
        case RawValue(EM_CSKY): self = .csky
        case RawValue(EM_LOONGARCH): self = .loongarch
        case RawValue(EM_FRV): self = .frv
        case RawValue(EM_ALPHA): self = .alpha
        case RawValue(EM_CYGNUS_M32R): self = .cygnus_m32r
        case RawValue(EM_S390_OLD): self = .s390_old
        case RawValue(EM_CYGNUS_MN10300): self = .cygnus_mn10300
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
        case ._486: RawValue(EM_486)
        case ._860: RawValue(EM_860)
        case .mips: RawValue(EM_MIPS)
        case .mips_rs3_le: RawValue(EM_MIPS_RS3_LE)
        case .mips_rs4_be: RawValue(EM_MIPS_RS4_BE)
        case .parisc: RawValue(EM_PARISC)
        case .sparc32plus: RawValue(EM_SPARC32PLUS)
        case .ppc: RawValue(EM_PPC)
        case .ppc64: RawValue(EM_PPC64)
        case .spu: RawValue(EM_SPU)
        case .arm: RawValue(EM_ARM)
        case .sh: RawValue(EM_SH)
        case .sparcv9: RawValue(EM_SPARCV9)
        case .h8_300: RawValue(EM_H8_300)
        case .ia_64: RawValue(EM_IA_64)
        case .x86_64: RawValue(EM_X86_64)
        case .s390: RawValue(EM_S390)
        case .cris: RawValue(EM_CRIS)
        case .m32r: RawValue(EM_M32R)
        case .mn10300: RawValue(EM_MN10300)
        case .openrisc: RawValue(EM_OPENRISC)
        case .arcompact: RawValue(EM_ARCOMPACT)
        case .xtensa: RawValue(EM_XTENSA)
        case .blackfin: RawValue(EM_BLACKFIN)
        case .unicore: RawValue(EM_UNICORE)
        case .altera_nios2: RawValue(EM_ALTERA_NIOS2)
        case .ti_c6000: RawValue(EM_TI_C6000)
        case .hexagon: RawValue(EM_HEXAGON)
        case .nds32: RawValue(EM_NDS32)
        case .aarch64: RawValue(EM_AARCH64)
        case .tilepro: RawValue(EM_TILEPRO)
        case .microblaze: RawValue(EM_MICROBLAZE)
        case .tilegx: RawValue(EM_TILEGX)
        case .arcv2: RawValue(EM_ARCV2)
        case .riscv: RawValue(EM_RISCV)
        case .bpf: RawValue(EM_BPF)
        case .csky: RawValue(EM_CSKY)
        case .loongarch: RawValue(EM_LOONGARCH)
        case .frv: RawValue(EM_FRV)
        case .alpha: RawValue(EM_ALPHA)
        case .cygnus_m32r: RawValue(EM_CYGNUS_M32R)
        case .s390_old: RawValue(EM_S390_OLD)
        case .cygnus_mn10300: RawValue(EM_CYGNUS_MN10300)
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
        case ._486: "EM_486"
        case ._860: "EM_860"
        case .mips: "EM_MIPS"
        case .mips_rs3_le: "EM_MIPS_RS3_LE"
        case .mips_rs4_be: "EM_MIPS_RS4_BE"
        case .parisc: "EM_PARISC"
        case .sparc32plus: "EM_SPARC32PLUS"
        case .ppc: "EM_PPC"
        case .ppc64: "EM_PPC64"
        case .spu: "EM_SPU"
        case .arm: "EM_ARM"
        case .sh: "EM_SH"
        case .sparcv9: "EM_SPARCV9"
        case .h8_300: "EM_H8_300"
        case .ia_64: "EM_IA_64"
        case .x86_64: "EM_X86_64"
        case .s390: "EM_S390"
        case .cris: "EM_CRIS"
        case .m32r: "EM_M32R"
        case .mn10300: "EM_MN10300"
        case .openrisc: "EM_OPENRISC"
        case .arcompact: "EM_ARCOMPACT"
        case .xtensa: "EM_XTENSA"
        case .blackfin: "EM_BLACKFIN"
        case .unicore: "EM_UNICORE"
        case .altera_nios2: "EM_ALTERA_NIOS2"
        case .ti_c6000: "EM_TI_C6000"
        case .hexagon: "EM_HEXAGON"
        case .nds32: "EM_NDS32"
        case .aarch64: "EM_AARCH64"
        case .tilepro: "EM_TILEPRO"
        case .microblaze: "EM_MICROBLAZE"
        case .tilegx: "EM_TILEGX"
        case .arcv2: "EM_ARCV2"
        case .riscv: "EM_RISCV"
        case .bpf: "EM_BPF"
        case .csky: "EM_CSKY"
        case .loongarch: "EM_LOONGARCH"
        case .frv: "EM_FRV"
        case .alpha: "EM_ALPHA"
        case .cygnus_m32r: "EM_CYGNUS_M32R"
        case .s390_old: "EM_S390_OLD"
        case .cygnus_mn10300: "EM_CYGNUS_MN10300"
        }
    }
}
