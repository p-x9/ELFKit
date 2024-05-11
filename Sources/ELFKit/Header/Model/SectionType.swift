//
//  SectionType.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
import ELFKitC

public enum SectionType: CaseIterable {
    /// SHT_NULL
    case null
    /// SHT_PROGBITS
    case progbits
    /// SHT_SYMTAB
    case symtab
    /// SHT_STRTAB
    case strtab
    /// SHT_RELA
    case rela
    /// SHT_HASH
    case hash
    /// SHT_DYNAMIC
    case dynamic
    /// SHT_NOTE
    case note
    /// SHT_NOBITS
    case nobits
    /// SHT_REL
    case rel
    /// SHT_SHLIB
    case shlib
    /// SHT_DYNSYM
    case dynsym
    /// SHT_INIT_ARRAY
    case init_array
    /// SHT_FINI_ARRAY
    case fini_array
    /// SHT_PREINIT_ARRAY
    case preinit_array
    /// SHT_GROUP
    case group
    /// SHT_SYMTAB_SHNDX
    case symtab_shndx
    /// SHT_RELR
    case relr
    /// SHT_GNU_INCREMENTAL_INPUTS
    case gnu_incremental_inputs
    /// SHT_GNU_ATTRIBUTES
    case gnu_attributes
    /// SHT_GNU_HASH
    case gnu_hash
    /// SHT_GNU_LIBLIST
    case gnu_liblist
    /// SHT_SUNW_ancillary
    case sunw_ancillary
    /// SHT_SUNW_capchain
    case sunw_capchain
    /// SHT_SUNW_capinfo
    case sunw_capinfo
    /// SHT_SUNW_symsort
    case sunw_symsort
    /// SHT_SUNW_tlssort
    case sunw_tlssort
    /// SHT_SUNW_LDYNSYM
    case sunw_ldynsym
    /// SHT_SUNW_dof
    case sunw_dof
    /// SHT_SUNW_cap
    case sunw_cap
    /// SHT_SUNW_SIGNATURE
    case sunw_signature
    /// SHT_SUNW_ANNOTATE
    case sunw_annotate
    /// SHT_SUNW_DEBUGSTR
    case sunw_debugstr
    /// SHT_SUNW_DEBUG
    case sunw_debug
    /// SHT_SUNW_move
    case sunw_move
    /// SHT_SUNW_COMDAT
    case sunw_comdat
    /// SHT_SUNW_syminfo
    case sunw_syminfo
    /// SHT_SUNW_verdef
    case sunw_verdef
    /// SHT_SUNW_verneed
    case sunw_verneed
    /// SHT_SUNW_versym
    case sunw_versym
    /// SHT_GNU_verdef
    case gnu_verdef
    /// SHT_GNU_verneed
    case gnu_verneed
    /// SHT_GNU_versym
    case gnu_versym
    /// SHT_AARCH64_ATTRIBUTES
    case aarch64_attributes
    /// SHT_ALPHA_DEBUG
    case alpha_debug
    /// SHT_ALPHA_REGINFO
    case alpha_reginfo
    /// SHT_ARC_ATTRIBUTES
    case arc_attributes
    /// SHT_ARM_EXIDX
    case arm_exidx
    /// SHT_ARM_PREEMPTMAP
    case arm_preemptmap
    /// SHT_ARM_ATTRIBUTES
    case arm_attributes
    /// SHT_ARM_DEBUGOVERLAY
    case arm_debugoverlay
    /// SHT_ARM_OVERLAYSECTION
    case arm_overlaysection
    /// SHT_CSKY_ATTRIBUTES
    case csky_attributes
    /// SHT_PARISC_EXT
    case parisc_ext
    /// SHT_PARISC_UNWIND
    case parisc_unwind
    /// SHT_PARISC_DOC
    case parisc_doc
    /// SHT_PARISC_ANNOT
    case parisc_annot
    /// SHT_PARISC_DLKM
    case parisc_dlkm
    /// SHT_PARISC_SYMEXTN
    case parisc_symextn
    /// SHT_PARISC_STUBS
    case parisc_stubs
    /// SHT_HP_OVLBITS
    case hp_ovlbits
    /// SHT_HP_DLKM
    case hp_dlkm
    /// SHT_HP_COMDAT
    case hp_comdat
    /// SHT_HP_OBJDICT
    case hp_objdict
    /// SHT_HP_ANNOT
    case hp_annot
    /// SHT_ORDERED
    case ordered
    /// SHT_IA_64_EXT
    case ia_64_ext
    /// SHT_IA_64_UNWIND
    case ia_64_unwind
    /// SHT_IA_64_PRIORITY_INIT
    case ia_64_priority_init
    /// SHT_IA_64_HP_OPT_ANOT
    case ia_64_hp_opt_anot
    /// SHT_IA_64_VMS_TRACE
    case ia_64_vms_trace
    /// SHT_IA_64_VMS_TIE_SIGNATURES
    case ia_64_vms_tie_signatures
    /// SHT_IA_64_VMS_DEBUG
    case ia_64_vms_debug
    /// SHT_IA_64_VMS_DEBUG_STR
    case ia_64_vms_debug_str
    /// SHT_IA_64_VMS_LINKAGES
    case ia_64_vms_linkages
    /// SHT_IA_64_VMS_SYMBOL_VECTOR
    case ia_64_vms_symbol_vector
    /// SHT_IA_64_VMS_FIXUP
    case ia_64_vms_fixup
    /// SHT_IA_64_VMS_DISPLAY_NAME_INFO
    case ia_64_vms_display_name_info
    /// SHT_MIPS_LIBLIST
    case mips_liblist
    /// SHT_MIPS_MSYM
    case mips_msym
    /// SHT_MIPS_CONFLICT
    case mips_conflict
    /// SHT_MIPS_GPTAB
    case mips_gptab
    /// SHT_MIPS_UCODE
    case mips_ucode
    /// SHT_MIPS_DEBUG
    case mips_debug
    /// SHT_MIPS_REGINFO
    case mips_reginfo
    /// SHT_MIPS_PACKAGE
    case mips_package
    /// SHT_MIPS_PACKSYM
    case mips_packsym
    /// SHT_MIPS_RELD
    case mips_reld
    /// SHT_MIPS_IFACE
    case mips_iface
    /// SHT_MIPS_CONTENT
    case mips_content
    /// SHT_MIPS_OPTIONS
    case mips_options
    /// SHT_MIPS_SHDR
    case mips_shdr
    /// SHT_MIPS_FDESC
    case mips_fdesc
    /// SHT_MIPS_EXTSYM
    case mips_extsym
    /// SHT_MIPS_DENSE
    case mips_dense
    /// SHT_MIPS_PDESC
    case mips_pdesc
    /// SHT_MIPS_LOCSYM
    case mips_locsym
    /// SHT_MIPS_AUXSYM
    case mips_auxsym
    /// SHT_MIPS_OPTSYM
    case mips_optsym
    /// SHT_MIPS_LOCSTR
    case mips_locstr
    /// SHT_MIPS_LINE
    case mips_line
    /// SHT_MIPS_RFDESC
    case mips_rfdesc
    /// SHT_MIPS_DELTASYM
    case mips_deltasym
    /// SHT_MIPS_DELTAINST
    case mips_deltainst
    /// SHT_MIPS_DELTACLASS
    case mips_deltaclass
    /// SHT_MIPS_DWARF
    case mips_dwarf
    /// SHT_MIPS_DELTADECL
    case mips_deltadecl
    /// SHT_MIPS_SYMBOL_LIB
    case mips_symbol_lib
    /// SHT_MIPS_EVENTS
    case mips_events
    /// SHT_MIPS_TRANSLATE
    case mips_translate
    /// SHT_MIPS_PIXIE
    case mips_pixie
    /// SHT_MIPS_XLATE
    case mips_xlate
    /// SHT_MIPS_XLATE_DEBUG
    case mips_xlate_debug
    /// SHT_MIPS_WHIRL
    case mips_whirl
    /// SHT_MIPS_EH_REGION
    case mips_eh_region
    /// SHT_MIPS_XLATE_OLD
    case mips_xlate_old
    /// SHT_MIPS_PDR_EXCEPTION
    case mips_pdr_exception
    /// SHT_MIPS_ABIFLAGS
    case mips_abiflags
    /// SHT_MIPS_XHASH
    case mips_xhash
    /// SHT_MSP430_ATTRIBUTES
    case msp430_attributes
    /// SHT_MSP430_SEC_FLAGS
    case msp430_sec_flags
    /// SHT_MSP430_SYM_ALIASES
    case msp430_sym_aliases
    /// SHT_NFP_MECONFIG
    case nfp_meconfig
    /// SHT_NFP_INITREG
    case nfp_initreg
    /// SHT_NFP_UDEBUG
    case nfp_udebug
    /// SHT_RISCV_ATTRIBUTES
    case riscv_attributes
    /// SHT_C6000_UNWIND
    case c6000_unwind
    /// SHT_C6000_PREEMPTMAP
    case c6000_preemptmap
    /// SHT_C6000_ATTRIBUTES
    case c6000_attributes
    /// SHT_TI_ICODE
    case ti_icode
    /// SHT_TI_XREF
    case ti_xref
    /// SHT_TI_HANDLER
    case ti_handler
    /// SHT_TI_INITINFO
    case ti_initinfo
    /// SHT_TI_PHATTRS
    case ti_phattrs
    /// SHT_V850_SCOMMON
    case v850_scommon
    /// SHT_V850_TCOMMON
    case v850_tcommon
    /// SHT_V850_ZCOMMON
    case v850_zcommon
    /// SHT_RENESAS_IOP
    case renesas_iop
    /// SHT_RENESAS_INFO
    case renesas_info
    /// SHT_X86_64_UNWIND
    case x86_64_unwind
}


extension SectionType/*: RawRepresentable*/ {
    public typealias RawValue = UInt32

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        switch rawValue {
        case 0: self = .null
        case 1: self = .progbits
        case 2: self = .symtab
        case 3: self = .strtab
        case 4: self = .rela
        case 5: self = .hash
        case 6: self = .dynamic
        case 7: self = .note
        case 8: self = .nobits
        case 9: self = .rel
        case 10: self = .shlib
        case 11: self = .dynsym
        case 14: self = .init_array
        case 15: self = .fini_array
        case 16: self = .preinit_array
        case 17: self = .group
        case 18: self = .symtab_shndx
        case 19: self = .relr

        default:
            switch (osabi, machine, rawValue) {
            case (.solaris, _, 0x6fffffee): self = .sunw_ancillary
            case (.solaris, _, 0x6fffffef): self = .sunw_capchain
            case (.solaris, _, 0x6ffffff0): self = .sunw_capinfo
            case (.solaris, _, 0x6ffffff1): self = .sunw_symsort
            case (.solaris, _, 0x6ffffff2): self = .sunw_tlssort
            case (.solaris, _, 0x6ffffff3): self = .sunw_ldynsym
            case (.solaris, _, 0x6ffffff4): self = .sunw_dof
            case (.solaris, _, 0x6ffffff5): self = .sunw_cap
            case (.solaris, _, 0x6ffffff6): self = .sunw_signature
            case (.solaris, _, 0x6ffffff7): self = .sunw_annotate
            case (.solaris, _, 0x6ffffff8): self = .sunw_debugstr
            case (.solaris, _, 0x6ffffff9): self = .sunw_debug
            case (.solaris, _, 0x6ffffffa): self = .sunw_move
            case (.solaris, _, 0x6ffffffb): self = .sunw_comdat
            case (.solaris, _, 0x6ffffffc): self = .sunw_syminfo
            case (.solaris, _, 0x6ffffffd): self = .sunw_verdef
            case (.solaris, _, 0x6ffffffe): self = .sunw_verneed
            case (.solaris, _, 0x6fffffff): self = .sunw_versym

            case (.hpux, _, 0x60000000): self = .hp_ovlbits
            case (.hpux, _, 0x60000001): self = .hp_dlkm
            case (.hpux, _, 0x60000002): self = .hp_comdat
            case (.hpux, _, 0x60000003): self = .hp_objdict
            case (.hpux, _, 0x60000004): self = .hp_annot

            case (_, _, 0x6fff4700): self = .gnu_incremental_inputs
            case (_, _, 0x6ffffff5): self = .gnu_attributes
            case (_, _, 0x6ffffff6): self = .gnu_hash
            case (_, _, 0x6ffffff7): self = .gnu_liblist

            case (_, _, 0x6ffffffd): self = .gnu_verdef
            case (_, _, 0x6ffffffe): self = .gnu_verneed
            case (_, _, 0x6fffffff): self = .gnu_versym

            case _ where [.arc, .arc_compact].contains(machine):
                switch rawValue {
                case 0x70000001: self = .arc_attributes
                default:
                    return nil
                }

            case _ where [.mips, .mips_rs3_le].contains(machine):
                switch rawValue {
                case 0x70000000: self = .mips_liblist
                case 0x70000001: self = .mips_msym
                case 0x70000002: self = .mips_conflict
                case 0x70000003: self = .mips_gptab
                case 0x70000004: self = .mips_ucode
                case 0x70000005: self = .mips_debug
                case 0x70000006: self = .mips_reginfo
                case 0x70000007: self = .mips_package
                case 0x70000008: self = .mips_packsym
                case 0x70000009: self = .mips_reld
                case 0x7000000b: self = .mips_iface
                case 0x7000000c: self = .mips_content
                case 0x7000000d: self = .mips_options
                case 0x70000010: self = .mips_shdr
                case 0x70000011: self = .mips_fdesc
                case 0x70000012: self = .mips_extsym
                case 0x70000013: self = .mips_dense
                case 0x70000014: self = .mips_pdesc
                case 0x70000015: self = .mips_locsym
                case 0x70000016: self = .mips_auxsym
                case 0x70000017: self = .mips_optsym
                case 0x70000018: self = .mips_locstr
                case 0x70000019: self = .mips_line
                case 0x7000001a: self = .mips_rfdesc
                case 0x7000001b: self = .mips_deltasym
                case 0x7000001c: self = .mips_deltainst
                case 0x7000001d: self = .mips_deltaclass
                case 0x7000001e: self = .mips_dwarf
                case 0x7000001f: self = .mips_deltadecl
                case 0x70000020: self = .mips_symbol_lib
                case 0x70000021: self = .mips_events
                case 0x70000022: self = .mips_translate
                case 0x70000023: self = .mips_pixie
                case 0x70000024: self = .mips_xlate
                case 0x70000025: self = .mips_xlate_debug
                case 0x70000026: self = .mips_whirl
                case 0x70000027: self = .mips_eh_region
                case 0x70000028: self = .mips_xlate_old
                case 0x70000029: self = .mips_pdr_exception
                case 0x7000002a: self = .mips_abiflags
                case 0x7000002b: self = .mips_xhash
                default:
                    return nil
                }

            case (_, .parisc, 0x70000000): self = .parisc_ext
            case (_, .parisc, 0x70000001): self = .parisc_unwind
            case (_, .parisc, 0x70000002): self = .parisc_doc
            case (_, .parisc, 0x70000003): self = .parisc_annot
            case (_, .parisc, 0x70000004): self = .parisc_dlkm

            case (_, .ia_64, 0x70000000): self = .ia_64_ext
            case (_, .ia_64, 0x70000001): self = .ia_64_unwind
            case (_, .ia_64, 0x79000000): self = .ia_64_priority_init
//            case (_, .ia_64, 0x60000004): self = .ia_64_hp_opt_anot
            case (_, .ia_64, 0x60000000): self = .ia_64_vms_trace
            case (_, .ia_64, 0x60000001): self = .ia_64_vms_tie_signatures
            case (_, .ia_64, 0x60000002): self = .ia_64_vms_debug
            case (_, .ia_64, 0x60000003): self = .ia_64_vms_debug_str
            case (_, .ia_64, 0x60000004): self = .ia_64_vms_linkages
            case (_, .ia_64, 0x60000005): self = .ia_64_vms_symbol_vector
            case (_, .ia_64, 0x60000006): self = .ia_64_vms_fixup
            case (_, .ia_64, 0x60000007): self = .ia_64_vms_display_name_info

            case (_, _, 0x70000001) where [.x86_64, .l10m, .k10m].contains(machine):
                self = .x86_64_unwind

            case (_, .aarch64, 0x70000003): self = .aarch64_attributes

            case (_, .arm, 0x70000001): self = .arm_exidx
            case (_, .arm, 0x70000002): self = .arm_preemptmap
            case (_, .arm, 0x70000003): self = .arm_attributes
            case (_, .arm, 0x70000004): self = .arm_debugoverlay
            case (_, .arm, 0x70000005): self = .arm_overlaysection

            case (_, .ti_c6000, 0x70000001): self = .c6000_unwind
            case (_, .ti_c6000, 0x70000002): self = .c6000_preemptmap
            case (_, .ti_c6000, 0x70000003): self = .c6000_attributes
            case (_, .ti_c6000, 0x7f000000): self = .ti_icode
            case (_, .ti_c6000, 0x7f000001): self = .ti_xref
            case (_, .ti_c6000, 0x7f000002): self = .ti_handler
            case (_, .ti_c6000, 0x7f000003): self = .ti_initinfo
            case (_, .ti_c6000, 0x7f000004): self = .ti_phattrs

            case (_, .msp430, 0x70000003): self = .msp430_attributes
            case (_, .msp430, 0x7f000005): self = .msp430_sec_flags
            case (_, .msp430, 0x7f000006): self = .msp430_sym_aliases

            case (_, .nfp, 0x70000003): self = .msp430_attributes
            case (_, .nfp, 0x7f000005): self = .msp430_sec_flags
            case (_, .nfp, 0x7f000006): self = .msp430_sym_aliases

            case _ where [.v800, .v850, .cygnus_v850].contains(machine):
                switch rawValue {
                case 0x70000000: self = .v850_scommon
                case 0x70000001: self = .v850_tcommon
                case 0x70000002: self = .v850_zcommon
                case 0x80000000: self = .renesas_iop
                case 0xa0000000: self = .renesas_info
                default:
                    return nil
                }

            case (_, .riscv, 0x70000003): self = .riscv_attributes

            case (_, .csky, 0x70000001): self = .csky_attributes

            case _ where [.alpha, .old_alpha].contains(machine):
                switch rawValue {
                case 0x70000001: self = .alpha_debug
                case 0x70000002: self = .alpha_reginfo
                default:
                    return nil
                }

            case (_, .parisc, 0x70000008): self = .parisc_symextn
            case (_, .parisc, 0x70000009): self = .parisc_stubs

            case (_, .nfp, 0x70000001): self = .nfp_meconfig
            case (_, .nfp, 0x70000002): self = .nfp_initreg
            case (_, .nfp, 0x80000000): self = .nfp_udebug

            case _ where [.ppc].contains(machine):
                switch rawValue {
                case 0x7fffffff: self = .ordered
                default:
                    return nil
                }

            default: return nil
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .null: 0
        case .progbits: 1
        case .symtab: 2
        case .strtab: 3
        case .rela: 4
        case .hash: 5
        case .dynamic: 6
        case .note: 7
        case .nobits: 8
        case .rel: 9
        case .shlib: 10
        case .dynsym: 11
        case .init_array: 14
        case .fini_array: 15
        case .preinit_array: 16
        case .group: 17
        case .symtab_shndx: 18
        case .relr: 19
        case .gnu_incremental_inputs: 0x6fff4700
        case .gnu_attributes: 0x6ffffff5
        case .gnu_hash: 0x6ffffff6
        case .gnu_liblist: 0x6ffffff7
        case .sunw_ancillary: 0x6fffffee
        case .sunw_capchain: 0x6fffffef
        case .sunw_capinfo: 0x6ffffff0
        case .sunw_symsort: 0x6ffffff1
        case .sunw_tlssort: 0x6ffffff2
        case .sunw_ldynsym: 0x6ffffff3
        case .sunw_dof: 0x6ffffff4
        case .sunw_cap: 0x6ffffff5
        case .sunw_signature: 0x6ffffff6
        case .sunw_annotate: 0x6ffffff7
        case .sunw_debugstr: 0x6ffffff8
        case .sunw_debug: 0x6ffffff9
        case .sunw_move: 0x6ffffffa
        case .sunw_comdat: 0x6ffffffb
        case .sunw_syminfo: 0x6ffffffc
        case .sunw_verdef: 0x6ffffffd
        case .sunw_verneed: 0x6ffffffe
        case .sunw_versym: 0x6fffffff
        case .gnu_verdef: 0x6ffffffd
        case .gnu_verneed: 0x6ffffffe
        case .gnu_versym: 0x6fffffff
        case .aarch64_attributes: 0x70000003
        case .alpha_debug: 0x70000001
        case .alpha_reginfo: 0x70000002
        case .arc_attributes: 0x70000001
        case .arm_exidx: 0x70000001
        case .arm_preemptmap: 0x70000002
        case .arm_attributes: 0x70000003
        case .arm_debugoverlay: 0x70000004
        case .arm_overlaysection: 0x70000005
        case .csky_attributes: 0x70000001
        case .parisc_ext: 0x70000000
        case .parisc_unwind: 0x70000001
        case .parisc_doc: 0x70000002
        case .parisc_annot: 0x70000003
        case .parisc_dlkm: 0x70000004
        case .parisc_symextn: 0x70000008
        case .parisc_stubs: 0x70000009
        case .hp_ovlbits: 0x60000000
        case .hp_dlkm: 0x60000001
        case .hp_comdat: 0x60000002
        case .hp_objdict: 0x60000003
        case .hp_annot: 0x60000004
        case .ordered: 0x7fffffff
        case .ia_64_ext: 0x70000000
        case .ia_64_unwind: 0x70000001
        case .ia_64_priority_init: 0x79000000
        case .ia_64_hp_opt_anot: 0x60000004
        case .ia_64_vms_trace: 0x60000000
        case .ia_64_vms_tie_signatures: 0x60000001
        case .ia_64_vms_debug: 0x60000002
        case .ia_64_vms_debug_str: 0x60000003
        case .ia_64_vms_linkages: 0x60000004
        case .ia_64_vms_symbol_vector: 0x60000005
        case .ia_64_vms_fixup: 0x60000006
        case .ia_64_vms_display_name_info: 0x60000007
        case .mips_liblist: 0x70000000
        case .mips_msym: 0x70000001
        case .mips_conflict: 0x70000002
        case .mips_gptab: 0x70000003
        case .mips_ucode: 0x70000004
        case .mips_debug: 0x70000005
        case .mips_reginfo: 0x70000006
        case .mips_package: 0x70000007
        case .mips_packsym: 0x70000008
        case .mips_reld: 0x70000009
        case .mips_iface: 0x7000000b
        case .mips_content: 0x7000000c
        case .mips_options: 0x7000000d
        case .mips_shdr: 0x70000010
        case .mips_fdesc: 0x70000011
        case .mips_extsym: 0x70000012
        case .mips_dense: 0x70000013
        case .mips_pdesc: 0x70000014
        case .mips_locsym: 0x70000015
        case .mips_auxsym: 0x70000016
        case .mips_optsym: 0x70000017
        case .mips_locstr: 0x70000018
        case .mips_line: 0x70000019
        case .mips_rfdesc: 0x7000001a
        case .mips_deltasym: 0x7000001b
        case .mips_deltainst: 0x7000001c
        case .mips_deltaclass: 0x7000001d
        case .mips_dwarf: 0x7000001e
        case .mips_deltadecl: 0x7000001f
        case .mips_symbol_lib: 0x70000020
        case .mips_events: 0x70000021
        case .mips_translate: 0x70000022
        case .mips_pixie: 0x70000023
        case .mips_xlate: 0x70000024
        case .mips_xlate_debug: 0x70000025
        case .mips_whirl: 0x70000026
        case .mips_eh_region: 0x70000027
        case .mips_xlate_old: 0x70000028
        case .mips_pdr_exception: 0x70000029
        case .mips_abiflags: 0x7000002a
        case .mips_xhash: 0x7000002b
        case .msp430_attributes: 0x70000003
        case .msp430_sec_flags: 0x7f000005
        case .msp430_sym_aliases: 0x7f000006
        case .nfp_meconfig: 0x70000001
        case .nfp_initreg: 0x70000002
        case .nfp_udebug: 0x80000000
        case .riscv_attributes: 0x70000003
        case .c6000_unwind: 0x70000001
        case .c6000_preemptmap: 0x70000002
        case .c6000_attributes: 0x70000003
        case .ti_icode: 0x7f000000
        case .ti_xref: 0x7f000001
        case .ti_handler: 0x7f000002
        case .ti_initinfo: 0x7f000003
        case .ti_phattrs: 0x7f000004
        case .v850_scommon: 0x70000000
        case .v850_tcommon: 0x70000001
        case .v850_zcommon: 0x70000002
        case .renesas_iop: 0x80000000
        case .renesas_info: 0xa0000000
        case .x86_64_unwind: 0x70000001
        }
    }
}

extension SectionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: "SHT_NULL"
        case .progbits: "SHT_PROGBITS"
        case .symtab: "SHT_SYMTAB"
        case .strtab: "SHT_STRTAB"
        case .rela: "SHT_RELA"
        case .hash: "SHT_HASH"
        case .dynamic: "SHT_DYNAMIC"
        case .note: "SHT_NOTE"
        case .nobits: "SHT_NOBITS"
        case .rel: "SHT_REL"
        case .shlib: "SHT_SHLIB"
        case .dynsym: "SHT_DYNSYM"
        case .init_array: "SHT_INIT_ARRAY"
        case .fini_array: "SHT_FINI_ARRAY"
        case .preinit_array: "SHT_PREINIT_ARRAY"
        case .group: "SHT_GROUP"
        case .symtab_shndx: "SHT_SYMTAB_SHNDX"
        case .relr: "SHT_RELR"
        case .gnu_incremental_inputs: "SHT_GNU_INCREMENTAL_INPUTS"
        case .gnu_attributes: "SHT_GNU_ATTRIBUTES"
        case .gnu_hash: "SHT_GNU_HASH"
        case .gnu_liblist: "SHT_GNU_LIBLIST"
        case .sunw_ancillary: "SHT_SUNW_ancillary"
        case .sunw_capchain: "SHT_SUNW_capchain"
        case .sunw_capinfo: "SHT_SUNW_capinfo"
        case .sunw_symsort: "SHT_SUNW_symsort"
        case .sunw_tlssort: "SHT_SUNW_tlssort"
        case .sunw_ldynsym: "SHT_SUNW_LDYNSYM"
        case .sunw_dof: "SHT_SUNW_dof"
        case .sunw_cap: "SHT_SUNW_cap"
        case .sunw_signature: "SHT_SUNW_SIGNATURE"
        case .sunw_annotate: "SHT_SUNW_ANNOTATE"
        case .sunw_debugstr: "SHT_SUNW_DEBUGSTR"
        case .sunw_debug: "SHT_SUNW_DEBUG"
        case .sunw_move: "SHT_SUNW_move"
        case .sunw_comdat: "SHT_SUNW_COMDAT"
        case .sunw_syminfo: "SHT_SUNW_syminfo"
        case .sunw_verdef: "SHT_SUNW_verdef"
        case .sunw_verneed: "SHT_SUNW_verneed"
        case .sunw_versym: "SHT_SUNW_versym"
        case .gnu_verdef: "SHT_GNU_verdef"
        case .gnu_verneed: "SHT_GNU_verneed"
        case .gnu_versym: "SHT_GNU_versym"
        case .aarch64_attributes: "SHT_AARCH64_ATTRIBUTES"
        case .alpha_debug: "SHT_ALPHA_DEBUG"
        case .alpha_reginfo: "SHT_ALPHA_REGINFO"
        case .arc_attributes: "SHT_ARC_ATTRIBUTES"
        case .arm_exidx: "SHT_ARM_EXIDX"
        case .arm_preemptmap: "SHT_ARM_PREEMPTMAP"
        case .arm_attributes: "SHT_ARM_ATTRIBUTES"
        case .arm_debugoverlay: "SHT_ARM_DEBUGOVERLAY"
        case .arm_overlaysection: "SHT_ARM_OVERLAYSECTION"
        case .csky_attributes: "SHT_CSKY_ATTRIBUTES"
        case .parisc_ext: "SHT_PARISC_EXT"
        case .parisc_unwind: "SHT_PARISC_UNWIND"
        case .parisc_doc: "SHT_PARISC_DOC"
        case .parisc_annot: "SHT_PARISC_ANNOT"
        case .parisc_dlkm: "SHT_PARISC_DLKM"
        case .parisc_symextn: "SHT_PARISC_SYMEXTN"
        case .parisc_stubs: "SHT_PARISC_STUBS"
        case .hp_ovlbits: "SHT_HP_OVLBITS"
        case .hp_dlkm: "SHT_HP_DLKM"
        case .hp_comdat: "SHT_HP_COMDAT"
        case .hp_objdict: "SHT_HP_OBJDICT"
        case .hp_annot: "SHT_HP_ANNOT"
        case .ordered: "SHT_ORDERED"
        case .ia_64_ext: "SHT_IA_64_EXT"
        case .ia_64_unwind: "SHT_IA_64_UNWIND"
        case .ia_64_priority_init: "SHT_IA_64_PRIORITY_INIT"
        case .ia_64_hp_opt_anot: "SHT_IA_64_HP_OPT_ANOT"
        case .ia_64_vms_trace: "SHT_IA_64_VMS_TRACE"
        case .ia_64_vms_tie_signatures: "SHT_IA_64_VMS_TIE_SIGNATURES"
        case .ia_64_vms_debug: "SHT_IA_64_VMS_DEBUG"
        case .ia_64_vms_debug_str: "SHT_IA_64_VMS_DEBUG_STR"
        case .ia_64_vms_linkages: "SHT_IA_64_VMS_LINKAGES"
        case .ia_64_vms_symbol_vector: "SHT_IA_64_VMS_SYMBOL_VECTOR"
        case .ia_64_vms_fixup: "SHT_IA_64_VMS_FIXUP"
        case .ia_64_vms_display_name_info: "SHT_IA_64_VMS_DISPLAY_NAME_INFO"
        case .mips_liblist: "SHT_MIPS_LIBLIST"
        case .mips_msym: "SHT_MIPS_MSYM"
        case .mips_conflict: "SHT_MIPS_CONFLICT"
        case .mips_gptab: "SHT_MIPS_GPTAB"
        case .mips_ucode: "SHT_MIPS_UCODE"
        case .mips_debug: "SHT_MIPS_DEBUG"
        case .mips_reginfo: "SHT_MIPS_REGINFO"
        case .mips_package: "SHT_MIPS_PACKAGE"
        case .mips_packsym: "SHT_MIPS_PACKSYM"
        case .mips_reld: "SHT_MIPS_RELD"
        case .mips_iface: "SHT_MIPS_IFACE"
        case .mips_content: "SHT_MIPS_CONTENT"
        case .mips_options: "SHT_MIPS_OPTIONS"
        case .mips_shdr: "SHT_MIPS_SHDR"
        case .mips_fdesc: "SHT_MIPS_FDESC"
        case .mips_extsym: "SHT_MIPS_EXTSYM"
        case .mips_dense: "SHT_MIPS_DENSE"
        case .mips_pdesc: "SHT_MIPS_PDESC"
        case .mips_locsym: "SHT_MIPS_LOCSYM"
        case .mips_auxsym: "SHT_MIPS_AUXSYM"
        case .mips_optsym: "SHT_MIPS_OPTSYM"
        case .mips_locstr: "SHT_MIPS_LOCSTR"
        case .mips_line: "SHT_MIPS_LINE"
        case .mips_rfdesc: "SHT_MIPS_RFDESC"
        case .mips_deltasym: "SHT_MIPS_DELTASYM"
        case .mips_deltainst: "SHT_MIPS_DELTAINST"
        case .mips_deltaclass: "SHT_MIPS_DELTACLASS"
        case .mips_dwarf: "SHT_MIPS_DWARF"
        case .mips_deltadecl: "SHT_MIPS_DELTADECL"
        case .mips_symbol_lib: "SHT_MIPS_SYMBOL_LIB"
        case .mips_events: "SHT_MIPS_EVENTS"
        case .mips_translate: "SHT_MIPS_TRANSLATE"
        case .mips_pixie: "SHT_MIPS_PIXIE"
        case .mips_xlate: "SHT_MIPS_XLATE"
        case .mips_xlate_debug: "SHT_MIPS_XLATE_DEBUG"
        case .mips_whirl: "SHT_MIPS_WHIRL"
        case .mips_eh_region: "SHT_MIPS_EH_REGION"
        case .mips_xlate_old: "SHT_MIPS_XLATE_OLD"
        case .mips_pdr_exception: "SHT_MIPS_PDR_EXCEPTION"
        case .mips_abiflags: "SHT_MIPS_ABIFLAGS"
        case .mips_xhash: "SHT_MIPS_XHASH"
        case .msp430_attributes: "SHT_MSP430_ATTRIBUTES"
        case .msp430_sec_flags: "SHT_MSP430_SEC_FLAGS"
        case .msp430_sym_aliases: "SHT_MSP430_SYM_ALIASES"
        case .nfp_meconfig: "SHT_NFP_MECONFIG"
        case .nfp_initreg: "SHT_NFP_INITREG"
        case .nfp_udebug: "SHT_NFP_UDEBUG"
        case .riscv_attributes: "SHT_RISCV_ATTRIBUTES"
        case .c6000_unwind: "SHT_C6000_UNWIND"
        case .c6000_preemptmap: "SHT_C6000_PREEMPTMAP"
        case .c6000_attributes: "SHT_C6000_ATTRIBUTES"
        case .ti_icode: "SHT_TI_ICODE"
        case .ti_xref: "SHT_TI_XREF"
        case .ti_handler: "SHT_TI_HANDLER"
        case .ti_initinfo: "SHT_TI_INITINFO"
        case .ti_phattrs: "SHT_TI_PHATTRS"
        case .v850_scommon: "SHT_V850_SCOMMON"
        case .v850_tcommon: "SHT_V850_TCOMMON"
        case .v850_zcommon: "SHT_V850_ZCOMMON"
        case .renesas_iop: "SHT_RENESAS_IOP"
        case .renesas_info: "SHT_RENESAS_INFO"
        case .x86_64_unwind: "SHT_X86_64_UNWIND"
        }
    }
}
