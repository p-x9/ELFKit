//
//  ELFMachine.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
import ELFKitC

public enum ELFMachine: UInt16, Sendable, CaseIterable {
    /// EM_NONE
    case none = 0
    /// EM_M32
    case m32 = 1
    /// EM_SPARC
    case sparc = 2
    /// EM_386
    case _386 = 3
    /// EM_68K
    case _68k = 4
    /// EM_88K
    case _88k = 5
    /// EM_IAMCU
    case iamcu = 6
    /// EM_860
    case _860 = 7
    /// EM_MIPS
    case mips = 8
    /// EM_S370
    case s370 = 9
    /// EM_MIPS_RS3_LE
    case mips_rs3_le = 10
    /// EM_OLD_SPARCV9
    case old_sparcv9 = 11
    /// EM_PARISC
    case parisc = 15
//    /// EM_PPC_OLD
//    case ppc_old = 17
    /// EM_VPP550
    case vpp550 = 17
    /// EM_SPARC32PLUS
    case sparc32plus = 18
    /// EM_960
    case _960 = 19
    /// EM_PPC
    case ppc = 20
    /// EM_PPC64
    case ppc64 = 21
    /// EM_S390
    case s390 = 22
    /// EM_SPU
    case spu = 23
    /// EM_V800
    case v800 = 36
    /// EM_FR20
    case fr20 = 37
    /// EM_RH32
    case rh32 = 38
    /// EM_MCORE
    case mcore = 39
//    /// EM_RCE
//    case rce = 39
    /// EM_ARM
    case arm = 40
    /// EM_OLD_ALPHA
    case old_alpha = 41
    /// EM_SH
    case sh = 42
    /// EM_SPARCV9
    case sparcv9 = 43
    /// EM_TRICORE
    case tricore = 44
    /// EM_ARC
    case arc = 45
    /// EM_H8_300
    case h8_300 = 46
    /// EM_H8_300H
    case h8_300h = 47
    /// EM_H8S
    case h8s = 48
    /// EM_H8_500
    case h8_500 = 49
    /// EM_IA_64
    case ia_64 = 50
    /// EM_MIPS_X
    case mips_x = 51
    /// EM_COLDFIRE
    case coldfire = 52
    /// EM_68HC12
    case _68hc12 = 53
    /// EM_MMA
    case mma = 54
    /// EM_PCP
    case pcp = 55
    /// EM_NCPU
    case ncpu = 56
    /// EM_NDR1
    case ndr1 = 57
    /// EM_STARCORE
    case starcore = 58
    /// EM_ME16
    case me16 = 59
    /// EM_ST100
    case st100 = 60
    /// EM_TINYJ
    case tinyj = 61
    /// EM_X86_64
    case x86_64 = 62
    /// EM_PDSP
    case pdsp = 63
    /// EM_PDP10
    case pdp10 = 64
    /// EM_PDP11
    case pdp11 = 65
    /// EM_FX66
    case fx66 = 66
    /// EM_ST9PLUS
    case st9plus = 67
    /// EM_ST7
    case st7 = 68
    /// EM_68HC16
    case _68hc16 = 69
    /// EM_68HC11
    case _68hc11 = 70
    /// EM_68HC08
    case _68hc08 = 71
    /// EM_68HC05
    case _68hc05 = 72
    /// EM_SVX
    case svx = 73
    /// EM_ST19
    case st19 = 74
    /// EM_VAX
    case vax = 75
    /// EM_CRIS
    case cris = 76
    /// EM_JAVELIN
    case javelin = 77
    /// EM_FIREPATH
    case firepath = 78
    /// EM_ZSP
    case zsp = 79
    /// EM_MMIX
    case mmix = 80
    /// EM_HUANY
    case huany = 81
    /// EM_PRISM
    case prism = 82
    /// EM_AVR
    case avr = 83
    /// EM_FR30
    case fr30 = 84
    /// EM_D10V
    case d10v = 85
    /// EM_D30V
    case d30v = 86
    /// EM_V850
    case v850 = 87
    /// EM_M32R
    case m32r = 88
    /// EM_MN10300
    case mn10300 = 89
    /// EM_MN10200
    case mn10200 = 90
    /// EM_PJ
    case pj = 91
    /// EM_OPENRISC
    case openrisc = 92
    /// EM_ARC_COMPACT
    case arc_compact = 93
    /// EM_XTENSA
    case xtensa = 94
//    /// EM_SCORE_OLD
//    case score_old = 95
    /// EM_VIDEOCORE
    case videocore = 95
    /// EM_TMM_GPP
    case tmm_gpp = 96
    /// EM_NS32K
    case ns32k = 97
    /// EM_TPC
    case tpc = 98
//    /// EM_PJ_OLD
//    case pj_old = 99
    /// EM_SNP1K
    case snp1k = 99
    /// EM_ST200
    case st200 = 100
    /// EM_IP2K
    case ip2k = 101
    /// EM_MAX
    case max = 102
    /// EM_CR
    case cr = 103
    /// EM_F2MC16
    case f2mc16 = 104
    /// EM_MSP430
    case msp430 = 105
    /// EM_BLACKFIN
    case blackfin = 106
    /// EM_SE_C33
    case se_c33 = 107
    /// EM_SEP
    case sep = 108
    /// EM_ARCA
    case arca = 109
    /// EM_UNICORE
    case unicore = 110
    /// EM_EXCESS
    case excess = 111
    /// EM_DXP
    case dxp = 112
    /// EM_ALTERA_NIOS2
    case altera_nios2 = 113
    /// EM_CRX
    case crx = 114
//    /// EM_CR16_OLD
//    case cr16_old = 115
    /// EM_XGATE
    case xgate = 115
    /// EM_C166
    case c166 = 116
    /// EM_M16C
    case m16c = 117
    /// EM_DSPIC30F
    case dspic30f = 118
    /// EM_CE
    case ce = 119
    /// EM_M32C
    case m32c = 120
    /// EM_TSK3000
    case tsk3000 = 131
    /// EM_RS08
    case rs08 = 132
    /// EM_SHARC
    case sharc = 133
    /// EM_ECOG2
    case ecog2 = 134
    /// EM_SCORE
    case score = 135
//    /// EM_SCORE7
//    case score7 = 135
    /// EM_DSP24
    case dsp24 = 136
    /// EM_VIDEOCORE3
    case videocore3 = 137
    /// EM_LATTICEMICO32
    case latticemico32 = 138
    /// EM_SE_C17
    case se_c17 = 139
    /// EM_TI_C6000
    case ti_c6000 = 140
    /// EM_TI_C2000
    case ti_c2000 = 141
    /// EM_TI_C5500
    case ti_c5500 = 142
    /// EM_TI_ARP32
    case ti_arp32 = 143
    /// EM_TI_PRU
    case ti_pru = 144
    /// EM_MMDSP_PLUS
    case mmdsp_plus = 160
    /// EM_CYPRESS_M8C
    case cypress_m8c = 161
    /// EM_R32C
    case r32c = 162
    /// EM_TRIMEDIA
    case trimedia = 163
    /// EM_QDSP6
    case qdsp6 = 164
    /// EM_8051
    case _8051 = 165
    /// EM_STXP7X
    case stxp7x = 166
    /// EM_NDS32
    case nds32 = 167
    /// EM_ECOG1
    case ecog1 = 168
//    /// EM_ECOG1X
//    case ecog1x = 168
    /// EM_MAXQ30
    case maxq30 = 169
    /// EM_XIMO16
    case ximo16 = 170
    /// EM_MANIK
    case manik = 171
    /// EM_CRAYNV2
    case craynv2 = 172
    /// EM_RX
    case rx = 173
    /// EM_METAG
    case metag = 174
    /// EM_MCST_ELBRUS
    case mcst_elbrus = 175
    /// EM_ECOG16
    case ecog16 = 176
    /// EM_CR16
    case cr16 = 177
    /// EM_ETPU
    case etpu = 178
    /// EM_SLE9X
    case sle9x = 179
    /// EM_L10M
    case l10m = 180
    /// EM_K10M
    case k10m = 181
    /// EM_INTEL182
    case intel182 = 182
    /// EM_AARCH64
    case aarch64 = 183
    /// EM_ARM184
    case arm184 = 184
    /// EM_AVR32
    case avr32 = 185
    /// EM_STM8
    case stm8 = 186
    /// EM_TILE64
    case tile64 = 187
    /// EM_TILEPRO
    case tilepro = 188
    /// EM_MICROBLAZE
    case microblaze = 189
    /// EM_CUDA
    case cuda = 190
    /// EM_TILEGX
    case tilegx = 191
    /// EM_CLOUDSHIELD
    case cloudshield = 192
    /// EM_COREA_1ST
    case corea_1st = 193
    /// EM_COREA_2ND
    case corea_2nd = 194
    /// EM_ARC_COMPACT2
    case arc_compact2 = 195
    /// EM_OPEN8
    case open8 = 196
    /// EM_RL78
    case rl78 = 197
    /// EM_VIDEOCORE5
    case videocore5 = 198
    /// EM_78KOR
    case _78kor = 199
    /// EM_56800EX
    case _56800ex = 200
    /// EM_BA1
    case ba1 = 201
    /// EM_BA2
    case ba2 = 202
    /// EM_XCORE
    case xcore = 203
    /// EM_MCHP_PIC
    case mchp_pic = 204
    /// EM_INTELGT
    case intelgt = 205
    /// EM_INTEL206
    case intel206 = 206
    /// EM_INTEL207
    case intel207 = 207
    /// EM_INTEL208
    case intel208 = 208
    /// EM_INTEL209
    case intel209 = 209
    /// EM_KM32
    case km32 = 210
    /// EM_KMX32
    case kmx32 = 211
    /// EM_EMX16
    case emx16 = 212
    /// EM_EMX8
    case emx8 = 213
    /// EM_KVARC
    case kvarc = 214
    /// EM_CDP
    case cdp = 215
    /// EM_COGE
    case coge = 216
    /// EM_COOL
    case cool = 217
    /// EM_NORC
    case norc = 218
    /// EM_CSR_KALIMBA
    case csr_kalimba = 219
    /// EM_Z80
    case z80 = 220
    /// EM_VISIUM
    case visium = 221
    /// EM_FT32
    case ft32 = 222
    /// EM_MOXIE
    case moxie = 223
    /// EM_AMDGPU
    case amdgpu = 224
    /// EM_RISCV
    case riscv = 243
    /// EM_LANAI
    case lanai = 244
    /// EM_CEVA
    case ceva = 245
    /// EM_CEVA_X2
    case ceva_x2 = 246
    /// EM_BPF
    case bpf = 247
    /// EM_GRAPHCORE_IPU
    case graphcore_ipu = 248
    /// EM_IMG1
    case img1 = 249
    /// EM_NFP
    case nfp = 250
    /// EM_VE
    case ve = 251
    /// EM_CSKY
    case csky = 252
    /// EM_ARC_COMPACT3_64
    case arc_compact3_64 = 253
    /// EM_MCS6502
    case mcs6502 = 254
    /// EM_ARC_COMPACT3
    case arc_compact3 = 0xff
    /// EM_KVX
    case kvx = 0x100
    /// EM_65816
    case _65816 = 0x101
    /// EM_LOONGARCH
    case loongarch = 0x102
    /// EM_KF32
    case kf32 = 0x103
    /// EM_U16_U8CORE
    case u16_u8core = 0x104
    /// EM_TACHYUM
    case tachyum = 0x105
    /// EM_56800EF
    case _56800ef = 0x106
    /// EM_AVR_OLD
    case avr_old = 0x1057
    /// EM_MSP430_OLD
    case msp430_old = 0x1059
    /// EM_MT
    case mt = 0x2530
    /// EM_CYGNUS_FR30
    case cygnus_fr30 = 0x3330
    /// EM_WEBASSEMBLY
    case webassembly = 0x4157
    /// EM_S12Z
    case s12z = 0x4def
    /// EM_DLX
    case dlx = 0x5aa5
    /// EM_CYGNUS_FRV
    case cygnus_frv = 0x5441
    /// EM_XC16X
    case xc16x = 0x4688
    /// EM_CYGNUS_D10V
    case cygnus_d10v = 0x7650
    /// EM_CYGNUS_D30V
    case cygnus_d30v = 0x7676
    /// EM_IP2K_OLD
    case ip2k_old = 0x8217
    /// EM_CYGNUS_POWERPC
    case cygnus_powerpc = 0x9025
    /// EM_ALPHA
    case alpha = 0x9026
    /// EM_CYGNUS_M32R
    case cygnus_m32r = 0x9041
    /// EM_CYGNUS_V850
    case cygnus_v850 = 0x9080
    /// EM_S390_OLD
    case s390_old = 0xa390
    /// EM_XTENSA_OLD
    case xtensa_old = 0xabc7
    /// EM_XSTORMY16
    case xstormy16 = 0xad45
    /// EM_CYGNUS_MN10300
    case cygnus_mn10300 = 0xbeef
    /// EM_CYGNUS_MN10200
    case cygnus_mn10200 = 0xdead
    /// EM_M32C_OLD
    case m32c_old = 0xfeb0
    /// EM_IQ2000
    case iq2000 = 0xfeba
    /// EM_NIOS32
    case nios32 = 0xfebb
    /// EM_CYGNUS_MEP
    case cygnus_mep = 0xf00d
    /// EM_MOXIE_OLD
    case moxie_old = 0xfeed
    /// EM_MICROBLAZE_OLD
    case microblaze_old = 0xbaab
    /// EM_ADAPTEVA_EPIPHANY
    case adapteva_epiphany = 0x1223
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
        case .old_sparcv9: "EM_OLD_SPARCV9"
        case .parisc: "EM_PARISC"
//        case .ppc_old: "EM_PPC_OLD"
        case .vpp550: "EM_VPP550"
        case .sparc32plus: "EM_SPARC32PLUS"
        case ._960: "EM_960"
        case .ppc: "EM_PPC"
        case .ppc64: "EM_PPC64"
        case .s390: "EM_S390"
        case .spu: "EM_SPU"
        case .v800: "EM_V800"
        case .fr20: "EM_FR20"
        case .rh32: "EM_RH32"
        case .mcore: "EM_MCORE"
//        case .rce: "EM_RCE"
        case .arm: "EM_ARM"
        case .old_alpha: "EM_OLD_ALPHA"
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
        case .pdsp: "EM_PDSP"
        case .pdp10: "EM_PDP10"
        case .pdp11: "EM_PDP11"
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
        case .arc_compact: "EM_ARC_COMPACT"
        case .xtensa: "EM_XTENSA"
//        case .score_old: "EM_SCORE_OLD"
        case .videocore: "EM_VIDEOCORE"
        case .tmm_gpp: "EM_TMM_GPP"
        case .ns32k: "EM_NS32K"
        case .tpc: "EM_TPC"
//        case .pj_old: "EM_PJ_OLD"
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
        case .excess: "EM_EXCESS"
        case .dxp: "EM_DXP"
        case .altera_nios2: "EM_ALTERA_NIOS2"
        case .crx: "EM_CRX"
//        case .cr16_old: "EM_CR16_OLD"
        case .xgate: "EM_XGATE"
        case .c166: "EM_C166"
        case .m16c: "EM_M16C"
        case .dspic30f: "EM_DSPIC30F"
        case .ce: "EM_CE"
        case .m32c: "EM_M32C"
        case .tsk3000: "EM_TSK3000"
        case .rs08: "EM_RS08"
        case .sharc: "EM_SHARC"
        case .ecog2: "EM_ECOG2"
        case .score: "EM_SCORE"
//        case .score7: "EM_SCORE7"
        case .dsp24: "EM_DSP24"
        case .videocore3: "EM_VIDEOCORE3"
        case .latticemico32: "EM_LATTICEMICO32"
        case .se_c17: "EM_SE_C17"
        case .ti_c6000: "EM_TI_C6000"
        case .ti_c2000: "EM_TI_C2000"
        case .ti_c5500: "EM_TI_C5500"
        case .ti_arp32: "EM_TI_ARP32"
        case .ti_pru: "EM_TI_PRU"
        case .mmdsp_plus: "EM_MMDSP_PLUS"
        case .cypress_m8c: "EM_CYPRESS_M8C"
        case .r32c: "EM_R32C"
        case .trimedia: "EM_TRIMEDIA"
        case .qdsp6: "EM_QDSP6"
        case ._8051: "EM_8051"
        case .stxp7x: "EM_STXP7X"
        case .nds32: "EM_NDS32"
        case .ecog1: "EM_ECOG1"
//        case .ecog1x: "EM_ECOG1X"
        case .maxq30: "EM_MAXQ30"
        case .ximo16: "EM_XIMO16"
        case .manik: "EM_MANIK"
        case .craynv2: "EM_CRAYNV2"
        case .rx: "EM_RX"
        case .metag: "EM_METAG"
        case .mcst_elbrus: "EM_MCST_ELBRUS"
        case .ecog16: "EM_ECOG16"
        case .cr16: "EM_CR16"
        case .etpu: "EM_ETPU"
        case .sle9x: "EM_SLE9X"
        case .l10m: "EM_L10M"
        case .k10m: "EM_K10M"
        case .intel182: "EM_INTEL182"
        case .aarch64: "EM_AARCH64"
        case .arm184: "EM_ARM184"
        case .avr32: "EM_AVR32"
        case .stm8: "EM_STM8"
        case .tile64: "EM_TILE64"
        case .tilepro: "EM_TILEPRO"
        case .microblaze: "EM_MICROBLAZE"
        case .cuda: "EM_CUDA"
        case .tilegx: "EM_TILEGX"
        case .cloudshield: "EM_CLOUDSHIELD"
        case .corea_1st: "EM_COREA_1ST"
        case .corea_2nd: "EM_COREA_2ND"
        case .arc_compact2: "EM_ARC_COMPACT2"
        case .open8: "EM_OPEN8"
        case .rl78: "EM_RL78"
        case .videocore5: "EM_VIDEOCORE5"
        case ._78kor: "EM_78KOR"
        case ._56800ex: "EM_56800EX"
        case .ba1: "EM_BA1"
        case .ba2: "EM_BA2"
        case .xcore: "EM_XCORE"
        case .mchp_pic: "EM_MCHP_PIC"
        case .intelgt: "EM_INTELGT"
        case .intel206: "EM_INTEL206"
        case .intel207: "EM_INTEL207"
        case .intel208: "EM_INTEL208"
        case .intel209: "EM_INTEL209"
        case .km32: "EM_KM32"
        case .kmx32: "EM_KMX32"
        case .emx16: "EM_EMX16"
        case .emx8: "EM_EMX8"
        case .kvarc: "EM_KVARC"
        case .cdp: "EM_CDP"
        case .coge: "EM_COGE"
        case .cool: "EM_COOL"
        case .norc: "EM_NORC"
        case .csr_kalimba: "EM_CSR_KALIMBA"
        case .z80: "EM_Z80"
        case .visium: "EM_VISIUM"
        case .ft32: "EM_FT32"
        case .moxie: "EM_MOXIE"
        case .amdgpu: "EM_AMDGPU"
        case .riscv: "EM_RISCV"
        case .lanai: "EM_LANAI"
        case .ceva: "EM_CEVA"
        case .ceva_x2: "EM_CEVA_X2"
        case .bpf: "EM_BPF"
        case .graphcore_ipu: "EM_GRAPHCORE_IPU"
        case .img1: "EM_IMG1"
        case .nfp: "EM_NFP"
        case .ve: "EM_VE"
        case .csky: "EM_CSKY"
        case .arc_compact3_64: "EM_ARC_COMPACT3_64"
        case .mcs6502: "EM_MCS6502"
        case .arc_compact3: "EM_ARC_COMPACT3"
        case .kvx: "EM_KVX"
        case ._65816: "EM_65816"
        case .loongarch: "EM_LOONGARCH"
        case .kf32: "EM_KF32"
        case .u16_u8core: "EM_U16_U8CORE"
        case .tachyum: "EM_TACHYUM"
        case ._56800ef: "EM_56800EF"
        case .avr_old: "EM_AVR_OLD"
        case .msp430_old: "EM_MSP430_OLD"
        case .mt: "EM_MT"
        case .cygnus_fr30: "EM_CYGNUS_FR30"
        case .webassembly: "EM_WEBASSEMBLY"
        case .s12z: "EM_S12Z"
        case .dlx: "EM_DLX"
        case .cygnus_frv: "EM_CYGNUS_FRV"
        case .xc16x: "EM_XC16X"
        case .cygnus_d10v: "EM_CYGNUS_D10V"
        case .cygnus_d30v: "EM_CYGNUS_D30V"
        case .ip2k_old: "EM_IP2K_OLD"
        case .cygnus_powerpc: "EM_CYGNUS_POWERPC"
        case .alpha: "EM_ALPHA"
        case .cygnus_m32r: "EM_CYGNUS_M32R"
        case .cygnus_v850: "EM_CYGNUS_V850"
        case .s390_old: "EM_S390_OLD"
        case .xtensa_old: "EM_XTENSA_OLD"
        case .xstormy16: "EM_XSTORMY16"
        case .cygnus_mn10300: "EM_CYGNUS_MN10300"
        case .cygnus_mn10200: "EM_CYGNUS_MN10200"
        case .m32c_old: "EM_M32C_OLD"
        case .iq2000: "EM_IQ2000"
        case .nios32: "EM_NIOS32"
        case .cygnus_mep: "EM_CYGNUS_MEP"
        case .moxie_old: "EM_MOXIE_OLD"
        case .microblaze_old: "EM_MICROBLAZE_OLD"
        case .adapteva_epiphany: "EM_ADAPTEVA_EPIPHANY"
        }
    }
}
