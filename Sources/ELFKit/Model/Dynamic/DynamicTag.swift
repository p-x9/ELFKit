//
//  DynamicTag.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public enum DynamicTag: CaseIterable {
    /// DT_NULL
    case null
    /// DT_NEEDED
    case needed
    /// DT_PLTRELSZ
    case pltrelsz
    /// DT_PLTGOT
    case pltgot
    /// DT_HASH
    case hash
    /// DT_STRTAB
    case strtab
    /// DT_SYMTAB
    case symtab
    /// DT_RELA
    case rela
    /// DT_RELASZ
    case relasz
    /// DT_RELAENT
    case relaent
    /// DT_STRSZ
    case strsz
    /// DT_SYMENT
    case syment
    /// DT_INIT
    case `init`
    /// DT_FINI
    case fini
    /// DT_SONAME
    case soname
    /// DT_RPATH
    case rpath
    /// DT_SYMBOLIC
    case symbolic
    /// DT_REL
    case rel
    /// DT_RELSZ
    case relsz
    /// DT_RELENT
    case relent
    /// DT_PLTREL
    case pltrel
    /// DT_DEBUG
    case debug
    /// DT_TEXTREL
    case textrel
    /// DT_JMPREL
    case jmprel
    /// DT_BIND_NOW
    case bind_now
    /// DT_INIT_ARRAY
    case init_array
    /// DT_FINI_ARRAY
    case fini_array
    /// DT_INIT_ARRAYSZ
    case init_arraysz
    /// DT_FINI_ARRAYSZ
    case fini_arraysz
    /// DT_RUNPATH
    case runpath
    /// DT_FLAGS
    case flags
    /// DT_ENCODING
    case encoding
    /// DT_PREINIT_ARRAY
    case preinit_array
    /// DT_PREINIT_ARRAYSZ
    case preinit_arraysz
    /// DT_SYMTAB_SHNDX
    case symtab_shndx
    /// DT_RELRSZ
    case relrsz
    /// DT_RELR
    case relr
    /// DT_RELRENT
    case relrent
//    /// DT_VALRNGLO
//    case valrnglo
    /// DT_GNU_FLAGS_1
    case gnu_flags_1
    /// DT_GNU_PRELINKED
    case gnu_prelinked
    /// DT_GNU_CONFLICTSZ
    case gnu_conflictsz
    /// DT_GNU_LIBLISTSZ
    case gnu_liblistsz
    /// DT_CHECKSUM
    case checksum
    /// DT_PLTPADSZ
    case pltpadsz
    /// DT_MOVEENT
    case moveent
    /// DT_MOVESZ
    case movesz
    /// DT_FEATURE
    case feature
    /// DT_POSFLAG_1
    case posflag_1
    /// DT_SYMINSZ
    case syminsz
    /// DT_SYMINENT
    case syminent
//    /// DT_VALRNGHI
//    case valrnghi
//    /// DT_ADDRRNGLO
//    case addrrnglo
    /// DT_GNU_HASH
    case gnu_hash
    /// DT_TLSDESC_PLT
    case tlsdesc_plt
    /// DT_TLSDESC_GOT
    case tlsdesc_got
    /// DT_GNU_CONFLICT
    case gnu_conflict
    /// DT_GNU_LIBLIST
    case gnu_liblist
    /// DT_CONFIG
    case config
    /// DT_DEPAUDIT
    case depaudit
    /// DT_AUDIT
    case audit
    /// DT_PLTPAD
    case pltpad
    /// DT_MOVETAB
    case movetab
    /// DT_SYMINFO
    case syminfo
//    /// DT_ADDRRNGHI
//    case addrrnghi
    /// DT_RELACOUNT
    case relacount
    /// DT_RELCOUNT
    case relcount
    /// DT_FLAGS_1
    case flags_1
    /// DT_VERDEF
    case verdef
    /// DT_VERDEFNUM
    case verdefnum
    /// DT_VERNEED
    case verneed
    /// DT_VERNEEDNUM
    case verneednum
    /// DT_VERSYM
    case versym
    /// DT_AUXILIARY
    case auxiliary
    /// DT_USED
    case used
    /// DT_FILTER
    case filter
    /// DT_AARCH64_BTI_PLT
    case aarch64_bti_plt
    /// DT_AARCH64_PAC_PLT
    case aarch64_pac_plt
    /// DT_AARCH64_VARIANT_PCS
    case aarch64_variant_pcs
    /// DT_ALPHA_PLTRO
    case alpha_pltro
    /// DT_HP_LOAD_MAP
    case hp_load_map
    /// DT_HP_DLD_FLAGS
    case hp_dld_flags
    /// DT_HP_DLD_HOOK
    case hp_dld_hook
    /// DT_HP_UX10_INIT
    case hp_ux10_init
    /// DT_HP_UX10_INITSZ
    case hp_ux10_initsz
    /// DT_HP_PREINIT
    case hp_preinit
    /// DT_HP_PREINITSZ
    case hp_preinitsz
    /// DT_HP_NEEDED
    case hp_needed
    /// DT_HP_TIME_STAMP
    case hp_time_stamp
    /// DT_HP_CHECKSUM
    case hp_checksum
    /// DT_HP_GST_SIZE
    case hp_gst_size
    /// DT_HP_GST_VERSION
    case hp_gst_version
    /// DT_HP_GST_HASHVAL
    case hp_gst_hashval
    /// DT_HP_EPLTREL
    case hp_epltrel
    /// DT_HP_EPLTRELSZ
    case hp_epltrelsz
    /// DT_HP_FILTERED
    case hp_filtered
    /// DT_HP_FILTER_TLS
    case hp_filter_tls
    /// DT_HP_COMPAT_FILTERED
    case hp_compat_filtered
    /// DT_HP_LAZYLOAD
    case hp_lazyload
    /// DT_HP_BIND_NOW_COUNT
    case hp_bind_now_count
    /// DT_PLT
    case plt
    /// DT_PLT_SIZE
    case plt_size
    /// DT_DLT
    case dlt
    /// DT_DLT_SIZE
    case dlt_size
    /// DT_IA_64_PLT_RESERVE
    case ia_64_plt_reserve
    /// DT_IA_64_VMS_SUBTYPE
    case ia_64_vms_subtype
    /// DT_IA_64_VMS_IMGIOCNT
    case ia_64_vms_imgiocnt
    /// DT_IA_64_VMS_LNKFLAGS
    case ia_64_vms_lnkflags
    /// DT_IA_64_VMS_VIR_MEM_BLK_SIZ
    case ia_64_vms_vir_mem_blk_siz
    /// DT_IA_64_VMS_IDENT
    case ia_64_vms_ident
    /// DT_IA_64_VMS_NEEDED_IDENT
    case ia_64_vms_needed_ident
    /// DT_IA_64_VMS_IMG_RELA_CNT
    case ia_64_vms_img_rela_cnt
    /// DT_IA_64_VMS_SEG_RELA_CNT
    case ia_64_vms_seg_rela_cnt
    /// DT_IA_64_VMS_FIXUP_RELA_CNT
    case ia_64_vms_fixup_rela_cnt
    /// DT_IA_64_VMS_FIXUP_NEEDED
    case ia_64_vms_fixup_needed
    /// DT_IA_64_VMS_SYMVEC_CNT
    case ia_64_vms_symvec_cnt
    /// DT_IA_64_VMS_XLATED
    case ia_64_vms_xlated
    /// DT_IA_64_VMS_STACKSIZE
    case ia_64_vms_stacksize
    /// DT_IA_64_VMS_UNWINDSZ
    case ia_64_vms_unwindsz
    /// DT_IA_64_VMS_UNWIND_CODSEG
    case ia_64_vms_unwind_codseg
    /// DT_IA_64_VMS_UNWIND_INFOSEG
    case ia_64_vms_unwind_infoseg
    /// DT_IA_64_VMS_LINKTIME
    case ia_64_vms_linktime
    /// DT_IA_64_VMS_SEG_NO
    case ia_64_vms_seg_no
    /// DT_IA_64_VMS_SYMVEC_OFFSET
    case ia_64_vms_symvec_offset
    /// DT_IA_64_VMS_SYMVEC_SEG
    case ia_64_vms_symvec_seg
    /// DT_IA_64_VMS_UNWIND_OFFSET
    case ia_64_vms_unwind_offset
    /// DT_IA_64_VMS_UNWIND_SEG
    case ia_64_vms_unwind_seg
    /// DT_IA_64_VMS_STRTAB_OFFSET
    case ia_64_vms_strtab_offset
    /// DT_IA_64_VMS_SYSVER_OFFSET
    case ia_64_vms_sysver_offset
    /// DT_IA_64_VMS_IMG_RELA_OFF
    case ia_64_vms_img_rela_off
    /// DT_IA_64_VMS_SEG_RELA_OFF
    case ia_64_vms_seg_rela_off
    /// DT_IA_64_VMS_FIXUP_RELA_OFF
    case ia_64_vms_fixup_rela_off
    /// DT_IA_64_VMS_PLTGOT_OFFSET
    case ia_64_vms_pltgot_offset
    /// DT_IA_64_VMS_PLTGOT_SEG
    case ia_64_vms_pltgot_seg
    /// DT_IA_64_VMS_FPMODE
    case ia_64_vms_fpmode
    /// DT_MIPS_RLD_VERSION
    case mips_rld_version
    /// DT_MIPS_TIME_STAMP
    case mips_time_stamp
    /// DT_MIPS_ICHECKSUM
    case mips_ichecksum
    /// DT_MIPS_IVERSION
    case mips_iversion
    /// DT_MIPS_FLAGS
    case mips_flags
    /// DT_MIPS_BASE_ADDRESS
    case mips_base_address
    /// DT_MIPS_MSYM
    case mips_msym
    /// DT_MIPS_CONFLICT
    case mips_conflict
    /// DT_MIPS_LIBLIST
    case mips_liblist
    /// DT_MIPS_LOCAL_GOTNO
    case mips_local_gotno
    /// DT_MIPS_CONFLICTNO
    case mips_conflictno
    /// DT_MIPS_LIBLISTNO
    case mips_liblistno
    /// DT_MIPS_SYMTABNO
    case mips_symtabno
    /// DT_MIPS_UNREFEXTNO
    case mips_unrefextno
    /// DT_MIPS_GOTSYM
    case mips_gotsym
    /// DT_MIPS_HIPAGENO
    case mips_hipageno
    /// DT_MIPS_RLD_MAP
    case mips_rld_map
    /// DT_MIPS_DELTA_CLASS
    case mips_delta_class
    /// DT_MIPS_DELTA_CLASS_NO
    case mips_delta_class_no
    /// DT_MIPS_DELTA_INSTANCE
    case mips_delta_instance
    /// DT_MIPS_DELTA_INSTANCE_NO
    case mips_delta_instance_no
    /// DT_MIPS_DELTA_RELOC
    case mips_delta_reloc
    /// DT_MIPS_DELTA_RELOC_NO
    case mips_delta_reloc_no
    /// DT_MIPS_DELTA_SYM
    case mips_delta_sym
    /// DT_MIPS_DELTA_SYM_NO
    case mips_delta_sym_no
    /// DT_MIPS_DELTA_CLASSSYM
    case mips_delta_classsym
    /// DT_MIPS_DELTA_CLASSSYM_NO
    case mips_delta_classsym_no
    /// DT_MIPS_CXX_FLAGS
    case mips_cxx_flags
    /// DT_MIPS_PIXIE_INIT
    case mips_pixie_init
    /// DT_MIPS_SYMBOL_LIB
    case mips_symbol_lib
    /// DT_MIPS_LOCALPAGE_GOTIDX
    case mips_localpage_gotidx
    /// DT_MIPS_LOCAL_GOTIDX
    case mips_local_gotidx
    /// DT_MIPS_HIDDEN_GOTIDX
    case mips_hidden_gotidx
    /// DT_MIPS_PROTECTED_GOTIDX
    case mips_protected_gotidx
    /// DT_MIPS_OPTIONS
    case mips_options
    /// DT_MIPS_INTERFACE
    case mips_interface
    /// DT_MIPS_DYNSTR_ALIGN
    case mips_dynstr_align
    /// DT_MIPS_INTERFACE_SIZE
    case mips_interface_size
    /// DT_MIPS_RLD_TEXT_RESOLVE_ADDR
    case mips_rld_text_resolve_addr
    /// DT_MIPS_PERF_SUFFIX
    case mips_perf_suffix
    /// DT_MIPS_COMPACT_SIZE
    case mips_compact_size
    /// DT_MIPS_GP_VALUE
    case mips_gp_value
    /// DT_MIPS_AUX_DYNAMIC
    case mips_aux_dynamic
    /// DT_MIPS_PLTGOT
    case mips_pltgot
    /// DT_MIPS_RWPLT
    case mips_rwplt
    /// DT_MIPS_RLD_MAP_REL
    case mips_rld_map_rel
    /// DT_MIPS_XHASH
    case mips_xhash
    /// DT_NIOS2_GP
    case nios2_gp
    /// DT_PPC_GOT
    case ppc_got
    /// DT_PPC_OPT
    case ppc_opt
    /// DT_PPC64_GLINK
    case ppc64_glink
    /// DT_PPC64_OPD
    case ppc64_opd
    /// DT_PPC64_OPDSZ
    case ppc64_opdsz
    /// DT_PPC64_OPT
    case ppc64_opt
    /// DT_RISCV_VARIANT_CC
    case riscv_variant_cc
    /// DT_SCORE_BASE_ADDRESS
    case score_base_address
    /// DT_SCORE_LOCAL_GOTNO
    case score_local_gotno
    /// DT_SCORE_SYMTABNO
    case score_symtabno
    /// DT_SCORE_GOTSYM
    case score_gotsym
    /// DT_SCORE_UNREFEXTNO
    case score_unrefextno
    /// DT_SCORE_HIPAGENO
    case score_hipageno
    /// DT_SPARC_REGISTER
    case sparc_register
    /// DT_C6000_GSYM_OFFSET
    case c6000_gsym_offset
    /// DT_C6000_GSTR_OFFSET
    case c6000_gstr_offset
    /// DT_C6000_DSBT_BASE
    case c6000_dsbt_base
    /// DT_C6000_DSBT_SIZE
    case c6000_dsbt_size
    /// DT_C6000_PREEMPTMAP
    case c6000_preemptmap
    /// DT_C6000_DSBT_INDEX
    case c6000_dsbt_index
//    /// DT_VX_WRS_TLS_DATA_START
//    case vx_wrs_tls_data_start
//    /// DT_VX_WRS_TLS_DATA_SIZE
//    case vx_wrs_tls_data_size
//    /// DT_VX_WRS_TLS_DATA_ALIGN
//    case vx_wrs_tls_data_align
//    /// DT_VX_WRS_TLS_VARS_START
//    case vx_wrs_tls_vars_start
//    /// DT_VX_WRS_TLS_VARS_SIZE
//    case vx_wrs_tls_vars_size
    /// DT_X86_64_PLT
    case x86_64_plt
    /// DT_X86_64_PLTSZ
    case x86_64_pltsz
    /// DT_X86_64_PLTENT
    case x86_64_pltent
    /// DT_XTENSA_GOT_LOC_OFF
    case xtensa_got_loc_off
    /// DT_XTENSA_GOT_LOC_SZ
    case xtensa_got_loc_sz
    /// DT_SUNW_AUXILIARY
    case sunw_auxiliary
    /// DT_SUNW_RTLDINF
    case sunw_rtldinf
    /// DT_SUNW_FILTER
    case sunw_filter
    /// DT_SUNW_CAP
    case sunw_cap
    /// DT_SUNW_SYMTAB
    case sunw_symtab
    /// DT_SUNW_SYMSZ
    case sunw_symsz
    /// DT_SUNW_ENCODING
    case sunw_encoding
    /// DT_SUNW_SORTENT
    case sunw_sortent
    /// DT_SUNW_SYMSORT
    case sunw_symsort
    /// DT_SUNW_SYMSORTSZ
    case sunw_symsortsz
    /// DT_SUNW_TLSSORT
    case sunw_tlssort
    /// DT_SUNW_TLSSORTSZ
    case sunw_tlssortsz
    /// DT_SUNW_CAPINFO
    case sunw_capinfo
    /// DT_SUNW_STRPAD
    case sunw_strpad
    /// DT_SUNW_CAPCHAIN
    case sunw_capchain
    /// DT_SUNW_LDMACH
    case sunw_ldmach
    /// DT_SUNW_CAPCHAINENT
    case sunw_capchainent
    /// DT_SUNW_CAPCHAINSZ
    case sunw_capchainsz
    /// DT_SUNW_PARENT
    case sunw_parent
    /// DT_SUNW_ASLR
    case sunw_aslr
    /// DT_SUNW_RELAX
    case sunw_relax
    /// DT_SUNW_NXHEAP
    case sunw_nxheap
    /// DT_SUNW_NXSTACK
    case sunw_nxstack
}

extension DynamicTag/*: RawRepresentable*/ {
    public typealias RawValue = UInt64

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        switch rawValue {
        case 0: self = .null
        case 1: self = .needed
        case 2: self = .pltrelsz
        case 3: self = .pltgot
        case 4: self = .hash
        case 5: self = .strtab
        case 6: self = .symtab
        case 7: self = .rela
        case 8: self = .relasz
        case 9: self = .relaent
        case 10: self = .strsz
        case 11: self = .syment
        case 12: self = .`init`
        case 13: self = .fini
        case 14: self = .soname
        case 15: self = .rpath
        case 16: self = .symbolic
        case 17: self = .rel
        case 18: self = .relsz
        case 19: self = .relent
        case 20: self = .pltrel
        case 21: self = .debug
        case 22: self = .textrel
        case 23: self = .jmprel
        case 24: self = .bind_now
        case 25: self = .init_array
        case 26: self = .fini_array
        case 27: self = .init_arraysz
        case 28: self = .fini_arraysz
        case 29: self = .runpath
        case 30: self = .flags
//        case 32: self = .encoding
        case 32: self = .preinit_array
        case 33: self = .preinit_arraysz
        case 34: self = .symtab_shndx
        case 35: self = .relrsz
        case 36: self = .relr
        case 37: self = .relrent

        case 0x6ffffdf4: self = .gnu_flags_1
        case 0x6ffffdf5: self = .gnu_prelinked
        case 0x6ffffdf6: self = .gnu_conflictsz
        case 0x6ffffdf7: self = .gnu_liblistsz
        case 0x6ffffdf8: self = .checksum
        case 0x6ffffdf9: self = .pltpadsz
        case 0x6ffffdfa: self = .moveent
        case 0x6ffffdfb: self = .movesz
        case 0x6ffffdfc: self = .feature
        case 0x6ffffdfd: self = .posflag_1
        case 0x6ffffdfe: self = .syminsz
        case 0x6ffffdff: self = .syminent

        case 0x6ffffef5: self = .gnu_hash
        case 0x6ffffef6: self = .tlsdesc_plt
        case 0x6ffffef7: self = .tlsdesc_got
        case 0x6ffffef8: self = .gnu_conflict
        case 0x6ffffef9: self = .gnu_liblist
        case 0x6ffffefa: self = .config
        case 0x6ffffefb: self = .depaudit
        case 0x6ffffefc: self = .audit
        case 0x6ffffefd: self = .pltpad
        case 0x6ffffefe: self = .movetab
        case 0x6ffffeff: self = .syminfo

        case 0x6ffffff9: self = .relacount
        case 0x6ffffffa: self = .relcount
        case 0x6ffffffb: self = .flags_1
        case 0x6ffffffc: self = .verdef
        case 0x6ffffffd: self = .verdefnum
        case 0x6ffffffe: self = .verneed
        case 0x6fffffff: self = .verneednum
        case 0x6ffffff0: self = .versym
        case 0x7ffffffd: self = .auxiliary
        case 0x7ffffffe: self = .used
        case 0x7fffffff: self = .filter

        default:
            switch (osabi, machine, rawValue) {

            case (.solaris, _, 0x6000000d): self = .sunw_auxiliary
            case (.solaris, _, 0x6000000e): self = .sunw_rtldinf
            case (.solaris, _, 0x6000000f): self = .sunw_filter
            case (.solaris, _, 0x60000010): self = .sunw_cap
            case (.solaris, _, 0x60000011): self = .sunw_symtab
            case (.solaris, _, 0x60000012): self = .sunw_symsz
//            case 0x60000013: self = .sunw_encoding
            case (.solaris, _, 0x60000013): self = .sunw_sortent
            case (.solaris, _, 0x60000014): self = .sunw_symsort
            case (.solaris, _, 0x60000015): self = .sunw_symsortsz
            case (.solaris, _, 0x60000016): self = .sunw_tlssort
            case (.solaris, _, 0x60000017): self = .sunw_tlssortsz
            case (.solaris, _, 0x60000018): self = .sunw_capinfo
            case (.solaris, _, 0x60000019): self = .sunw_strpad
            case (.solaris, _, 0x6000001a): self = .sunw_capchain
            case (.solaris, _, 0x6000001b): self = .sunw_ldmach
            case (.solaris, _, 0x6000001d): self = .sunw_capchainent
            case (.solaris, _, 0x6000001f): self = .sunw_capchainsz
            case (.solaris, _, 0x60000021): self = .sunw_parent
            case (.solaris, _, 0x60000023): self = .sunw_aslr
            case (.solaris, _, 0x60000025): self = .sunw_relax
            case (.solaris, _, 0x60000029): self = .sunw_nxheap
            case (.solaris, _, 0x6000002b): self = .sunw_nxstack

            case (_, .aarch64, 0x70000001): self = .aarch64_bti_plt
            case (_, .aarch64, 0x70000003): self = .aarch64_pac_plt
            case (_, .aarch64, 0x70000005): self = .aarch64_variant_pcs

            case _ where [.mips, .mips_rs3_le].contains(machine):
                switch rawValue {
                case 0x70000001: self = .mips_rld_version
                case 0x70000002: self = .mips_time_stamp
                case 0x70000003: self = .mips_ichecksum
                case 0x70000004: self = .mips_iversion
                case 0x70000005: self = .mips_flags
                case 0x70000006: self = .mips_base_address
                case 0x70000007: self = .mips_msym
                case 0x70000008: self = .mips_conflict
                case 0x70000009: self = .mips_liblist
                case 0x7000000a: self = .mips_local_gotno
                case 0x7000000b: self = .mips_conflictno
                case 0x70000010: self = .mips_liblistno
                case 0x70000011: self = .mips_symtabno
                case 0x70000012: self = .mips_unrefextno
                case 0x70000013: self = .mips_gotsym
                case 0x70000014: self = .mips_hipageno
                case 0x70000016: self = .mips_rld_map
                case 0x70000017: self = .mips_delta_class
                case 0x70000018: self = .mips_delta_class_no
                case 0x70000019: self = .mips_delta_instance
                case 0x7000001a: self = .mips_delta_instance_no
                case 0x7000001b: self = .mips_delta_reloc
                case 0x7000001c: self = .mips_delta_reloc_no
                case 0x7000001d: self = .mips_delta_sym
                case 0x7000001e: self = .mips_delta_sym_no
                case 0x70000020: self = .mips_delta_classsym
                case 0x70000021: self = .mips_delta_classsym_no
                case 0x70000022: self = .mips_cxx_flags
                case 0x70000023: self = .mips_pixie_init
                case 0x70000024: self = .mips_symbol_lib
                case 0x70000025: self = .mips_localpage_gotidx
                case 0x70000026: self = .mips_local_gotidx
                case 0x70000027: self = .mips_hidden_gotidx
                case 0x70000028: self = .mips_protected_gotidx
                case 0x70000029: self = .mips_options
                case 0x7000002a: self = .mips_interface
                case 0x7000002b: self = .mips_dynstr_align
                case 0x7000002c: self = .mips_interface_size
                case 0x7000002d: self = .mips_rld_text_resolve_addr
                case 0x7000002e: self = .mips_perf_suffix
                case 0x7000002f: self = .mips_compact_size
                case 0x70000030: self = .mips_gp_value
                case 0x70000031: self = .mips_aux_dynamic
                case 0x70000032: self = .mips_pltgot
                case 0x70000034: self = .mips_rwplt
                case 0x70000035: self = .mips_rld_map_rel
                case 0x70000036: self = .mips_xhash
                default:
                    return nil
                }

            case (_, .sparcv9, 0x70000001): self = .sparc_register

            case (_, .ppc, 0x70000000): self = .ppc_got
            case (_, .ppc, 0x70000001): self = .ppc_opt

            case (_, .ppc64, 0x70000000): self = .ppc64_glink
            case (_, .ppc64, 0x70000001): self = .ppc64_opd
            case (_, .ppc64, 0x70000002): self = .ppc64_opdsz
            case (_, .ppc64, 0x70000003): self = .ppc64_opt

            case (_, .ia_64, 0x70000000): self = .ia_64_plt_reserve
            case (_, .ia_64, 0x6000000d): self = .ia_64_vms_subtype
            case (_, .ia_64, 0x6000000f): self = .ia_64_vms_imgiocnt
            case (_, .ia_64, 0x60000015): self = .ia_64_vms_lnkflags
            case (_, .ia_64, 0x60000017): self = .ia_64_vms_vir_mem_blk_siz
            case (_, .ia_64, 0x60000019): self = .ia_64_vms_ident
            case (_, .ia_64, 0x6000001d): self = .ia_64_vms_needed_ident
            case (_, .ia_64, 0x6000001f): self = .ia_64_vms_img_rela_cnt
            case (_, .ia_64, 0x60000021): self = .ia_64_vms_seg_rela_cnt
            case (_, .ia_64, 0x60000023): self = .ia_64_vms_fixup_rela_cnt
            case (_, .ia_64, 0x60000025): self = .ia_64_vms_fixup_needed
            case (_, .ia_64, 0x60000027): self = .ia_64_vms_symvec_cnt
            case (_, .ia_64, 0x6000002b): self = .ia_64_vms_xlated
            case (_, .ia_64, 0x6000002d): self = .ia_64_vms_stacksize
            case (_, .ia_64, 0x6000002f): self = .ia_64_vms_unwindsz
            case (_, .ia_64, 0x60000031): self = .ia_64_vms_unwind_codseg
            case (_, .ia_64, 0x60000033): self = .ia_64_vms_unwind_infoseg
            case (_, .ia_64, 0x60000035): self = .ia_64_vms_linktime
            case (_, .ia_64, 0x60000037): self = .ia_64_vms_seg_no
            case (_, .ia_64, 0x60000039): self = .ia_64_vms_symvec_offset
            case (_, .ia_64, 0x6000003b): self = .ia_64_vms_symvec_seg
            case (_, .ia_64, 0x6000003d): self = .ia_64_vms_unwind_offset
            case (_, .ia_64, 0x6000003f): self = .ia_64_vms_unwind_seg
            case (_, .ia_64, 0x60000041): self = .ia_64_vms_strtab_offset
            case (_, .ia_64, 0x60000043): self = .ia_64_vms_sysver_offset
            case (_, .ia_64, 0x60000045): self = .ia_64_vms_img_rela_off
            case (_, .ia_64, 0x60000047): self = .ia_64_vms_seg_rela_off
            case (_, .ia_64, 0x60000049): self = .ia_64_vms_fixup_rela_off
            case (_, .ia_64, 0x6000004b): self = .ia_64_vms_pltgot_offset
            case (_, .ia_64, 0x6000004d): self = .ia_64_vms_pltgot_seg
            case (_, .ia_64, 0x6000004f): self = .ia_64_vms_fpmode

            case (_, .alpha, 0x70000000): self = .alpha_pltro

            case (_, .score, 0x70000001): self = .score_base_address
            case (_, .score, 0x70000002): self = .score_local_gotno
            case (_, .score, 0x70000003): self = .score_symtabno
            case (_, .score, 0x70000004): self = .score_gotsym
            case (_, .score, 0x70000005): self = .score_unrefextno
            case (_, .score, 0x70000006): self = .score_hipageno

            case (_, .ti_c6000, 0x6000000d): self = .c6000_gsym_offset
            case (_, .ti_c6000, 0x6000000f): self = .c6000_gstr_offset
            case (_, .ti_c6000, 0x70000000): self = .c6000_dsbt_base
            case (_, .ti_c6000, 0x70000001): self = .c6000_dsbt_size
            case (_, .ti_c6000, 0x70000002): self = .c6000_preemptmap
            case (_, .ti_c6000, 0x70000003): self = .c6000_dsbt_index

            case (_, .altera_nios2, 0x70000002): self = .nios2_gp

            case (_, .riscv, 0x70000001): self = .riscv_variant_cc

            case (_, .x86_64, 0x70000000): self = .x86_64_plt
            case (_, .x86_64, 0x70000001): self = .x86_64_pltsz
            case (_, .x86_64, 0x70000003): self = .x86_64_pltent

            case (_, .parisc, 0x60000000): self = .hp_load_map
            case (_, .parisc, 0x60000001): self = .hp_dld_flags
            case (_, .parisc, 0x60000002): self = .hp_dld_hook
            case (_, .parisc, 0x60000003): self = .hp_ux10_init
            case (_, .parisc, 0x60000004): self = .hp_ux10_initsz
            case (_, .parisc, 0x60000005): self = .hp_preinit
            case (_, .parisc, 0x60000006): self = .hp_preinitsz
            case (_, .parisc, 0x60000007): self = .hp_needed
            case (_, .parisc, 0x60000008): self = .hp_time_stamp
            case (_, .parisc, 0x60000009): self = .hp_checksum
            case (_, .parisc, 0x6000000a): self = .hp_gst_size
            case (_, .parisc, 0x6000000b): self = .hp_gst_version
            case (_, .parisc, 0x6000000c): self = .hp_gst_hashval
            case (_, .parisc, 0x6000000d): self = .hp_epltrel
            case (_, .parisc, 0x6000000e): self = .hp_epltrelsz
            case (_, .parisc, 0x6000000f): self = .hp_filtered
            case (_, .parisc, 0x60000010): self = .hp_filter_tls
            case (_, .parisc, 0x60000011): self = .hp_compat_filtered
            case (_, .parisc, 0x60000012): self = .hp_lazyload
            case (_, .parisc, 0x60000013): self = .hp_bind_now_count
            case (_, .parisc, 0x60000014): self = .plt
            case (_, .parisc, 0x60000015): self = .plt_size
            case (_, .parisc, 0x60000016): self = .dlt
            case (_, .parisc, 0x60000017): self = .dlt_size

            case _ where [.xtensa, .xtensa_old].contains(machine):
                switch rawValue {
                case 0x70000000: self = .xtensa_got_loc_off
                case 0x70000001: self = .xtensa_got_loc_sz
                default:
                    return nil
                }

//            case 0x60000010: self = .vx_wrs_tls_data_start
//            case 0x60000011: self = .vx_wrs_tls_data_size
//            case 0x60000015: self = .vx_wrs_tls_data_align
//            case 0x60000012: self = .vx_wrs_tls_vars_start
//            case 0x60000013: self = .vx_wrs_tls_vars_size

            default: return nil
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .null: 0
        case .needed: 1
        case .pltrelsz: 2
        case .pltgot: 3
        case .hash: 4
        case .strtab: 5
        case .symtab: 6
        case .rela: 7
        case .relasz: 8
        case .relaent: 9
        case .strsz: 10
        case .syment: 11
        case .`init`: 12
        case .fini: 13
        case .soname: 14
        case .rpath: 15
        case .symbolic: 16
        case .rel: 17
        case .relsz: 18
        case .relent: 19
        case .pltrel: 20
        case .debug: 21
        case .textrel: 22
        case .jmprel: 23
        case .bind_now: 24
        case .init_array: 25
        case .fini_array: 26
        case .init_arraysz: 27
        case .fini_arraysz: 28
        case .runpath: 29
        case .flags: 30
        case .encoding: 32
        case .preinit_array: 32
        case .preinit_arraysz: 33
        case .symtab_shndx: 34
        case .relrsz: 35
        case .relr: 36
        case .relrent: 37
        case .gnu_flags_1: 0x6ffffdf4
        case .gnu_prelinked: 0x6ffffdf5
        case .gnu_conflictsz: 0x6ffffdf6
        case .gnu_liblistsz: 0x6ffffdf7
        case .checksum: 0x6ffffdf8
        case .pltpadsz: 0x6ffffdf9
        case .moveent: 0x6ffffdfa
        case .movesz: 0x6ffffdfb
        case .feature: 0x6ffffdfc
        case .posflag_1: 0x6ffffdfd
        case .syminsz: 0x6ffffdfe
        case .syminent: 0x6ffffdff
        case .gnu_hash: 0x6ffffef5
        case .tlsdesc_plt: 0x6ffffef6
        case .tlsdesc_got: 0x6ffffef7
        case .gnu_conflict: 0x6ffffef8
        case .gnu_liblist: 0x6ffffef9
        case .config: 0x6ffffefa
        case .depaudit: 0x6ffffefb
        case .audit: 0x6ffffefc
        case .pltpad: 0x6ffffefd
        case .movetab: 0x6ffffefe
        case .syminfo: 0x6ffffeff
        case .relacount: 0x6ffffff9
        case .relcount: 0x6ffffffa
        case .flags_1: 0x6ffffffb
        case .verdef: 0x6ffffffc
        case .verdefnum: 0x6ffffffd
        case .verneed: 0x6ffffffe
        case .verneednum: 0x6fffffff
        case .versym: 0x6ffffff0
        case .auxiliary: 0x7ffffffd
        case .used: 0x7ffffffe
        case .filter: 0x7fffffff
        case .aarch64_bti_plt: 0x70000001
        case .aarch64_pac_plt: 0x70000003
        case .aarch64_variant_pcs: 0x70000005
        case .alpha_pltro: 0x70000000
        case .hp_load_map: 0x60000000
        case .hp_dld_flags: 0x60000001
        case .hp_dld_hook: 0x60000002
        case .hp_ux10_init: 0x60000003
        case .hp_ux10_initsz: 0x60000004
        case .hp_preinit: 0x60000005
        case .hp_preinitsz: 0x60000006
        case .hp_needed: 0x60000007
        case .hp_time_stamp: 0x60000008
        case .hp_checksum: 0x60000009
        case .hp_gst_size: 0x6000000a
        case .hp_gst_version: 0x6000000b
        case .hp_gst_hashval: 0x6000000c
        case .hp_epltrel: 0x6000000d
        case .hp_epltrelsz: 0x6000000e
        case .hp_filtered: 0x6000000f
        case .hp_filter_tls: 0x60000010
        case .hp_compat_filtered: 0x60000011
        case .hp_lazyload: 0x60000012
        case .hp_bind_now_count: 0x60000013
        case .plt: 0x60000014
        case .plt_size: 0x60000015
        case .dlt: 0x60000016
        case .dlt_size: 0x60000017
        case .ia_64_plt_reserve: 0x70000000
        case .ia_64_vms_subtype: 0x6000000d
        case .ia_64_vms_imgiocnt: 0x6000000f
        case .ia_64_vms_lnkflags: 0x60000015
        case .ia_64_vms_vir_mem_blk_siz: 0x60000017
        case .ia_64_vms_ident: 0x60000019
        case .ia_64_vms_needed_ident: 0x6000001d
        case .ia_64_vms_img_rela_cnt: 0x6000001f
        case .ia_64_vms_seg_rela_cnt: 0x60000021
        case .ia_64_vms_fixup_rela_cnt: 0x60000023
        case .ia_64_vms_fixup_needed: 0x60000025
        case .ia_64_vms_symvec_cnt: 0x60000027
        case .ia_64_vms_xlated: 0x6000002b
        case .ia_64_vms_stacksize: 0x6000002d
        case .ia_64_vms_unwindsz: 0x6000002f
        case .ia_64_vms_unwind_codseg: 0x60000031
        case .ia_64_vms_unwind_infoseg: 0x60000033
        case .ia_64_vms_linktime: 0x60000035
        case .ia_64_vms_seg_no: 0x60000037
        case .ia_64_vms_symvec_offset: 0x60000039
        case .ia_64_vms_symvec_seg: 0x6000003b
        case .ia_64_vms_unwind_offset: 0x6000003d
        case .ia_64_vms_unwind_seg: 0x6000003f
        case .ia_64_vms_strtab_offset: 0x60000041
        case .ia_64_vms_sysver_offset: 0x60000043
        case .ia_64_vms_img_rela_off: 0x60000045
        case .ia_64_vms_seg_rela_off: 0x60000047
        case .ia_64_vms_fixup_rela_off: 0x60000049
        case .ia_64_vms_pltgot_offset: 0x6000004b
        case .ia_64_vms_pltgot_seg: 0x6000004d
        case .ia_64_vms_fpmode: 0x6000004f
        case .mips_rld_version: 0x70000001
        case .mips_time_stamp: 0x70000002
        case .mips_ichecksum: 0x70000003
        case .mips_iversion: 0x70000004
        case .mips_flags: 0x70000005
        case .mips_base_address: 0x70000006
        case .mips_msym: 0x70000007
        case .mips_conflict: 0x70000008
        case .mips_liblist: 0x70000009
        case .mips_local_gotno: 0x7000000a
        case .mips_conflictno: 0x7000000b
        case .mips_liblistno: 0x70000010
        case .mips_symtabno: 0x70000011
        case .mips_unrefextno: 0x70000012
        case .mips_gotsym: 0x70000013
        case .mips_hipageno: 0x70000014
        case .mips_rld_map: 0x70000016
        case .mips_delta_class: 0x70000017
        case .mips_delta_class_no: 0x70000018
        case .mips_delta_instance: 0x70000019
        case .mips_delta_instance_no: 0x7000001a
        case .mips_delta_reloc: 0x7000001b
        case .mips_delta_reloc_no: 0x7000001c
        case .mips_delta_sym: 0x7000001d
        case .mips_delta_sym_no: 0x7000001e
        case .mips_delta_classsym: 0x70000020
        case .mips_delta_classsym_no: 0x70000021
        case .mips_cxx_flags: 0x70000022
        case .mips_pixie_init: 0x70000023
        case .mips_symbol_lib: 0x70000024
        case .mips_localpage_gotidx: 0x70000025
        case .mips_local_gotidx: 0x70000026
        case .mips_hidden_gotidx: 0x70000027
        case .mips_protected_gotidx: 0x70000028
        case .mips_options: 0x70000029
        case .mips_interface: 0x7000002a
        case .mips_dynstr_align: 0x7000002b
        case .mips_interface_size: 0x7000002c
        case .mips_rld_text_resolve_addr: 0x7000002d
        case .mips_perf_suffix: 0x7000002e
        case .mips_compact_size: 0x7000002f
        case .mips_gp_value: 0x70000030
        case .mips_aux_dynamic: 0x70000031
        case .mips_pltgot: 0x70000032
        case .mips_rwplt: 0x70000034
        case .mips_rld_map_rel: 0x70000035
        case .mips_xhash: 0x70000036
        case .nios2_gp: 0x70000002
        case .ppc_got: 0x70000000
        case .ppc_opt: 0x70000001
        case .ppc64_glink: 0x70000000
        case .ppc64_opd: 0x70000001
        case .ppc64_opdsz: 0x70000002
        case .ppc64_opt: 0x70000003
        case .riscv_variant_cc: 0x70000001
        case .score_base_address: 0x70000001
        case .score_local_gotno: 0x70000002
        case .score_symtabno: 0x70000003
        case .score_gotsym: 0x70000004
        case .score_unrefextno: 0x70000005
        case .score_hipageno: 0x70000006
        case .sparc_register: 0x70000001
        case .c6000_gsym_offset: 0x6000000d
        case .c6000_gstr_offset: 0x6000000f
        case .c6000_dsbt_base: 0x70000000
        case .c6000_dsbt_size: 0x70000001
        case .c6000_preemptmap: 0x70000002
        case .c6000_dsbt_index: 0x70000003
//        case .vx_wrs_tls_data_start: 0x60000010
//        case .vx_wrs_tls_data_size: 0x60000011
//        case .vx_wrs_tls_data_align: 0x60000015
//        case .vx_wrs_tls_vars_start: 0x60000012
//        case .vx_wrs_tls_vars_size: 0x60000013
        case .x86_64_plt: 0x70000000
        case .x86_64_pltsz: 0x70000001
        case .x86_64_pltent: 0x70000003
        case .xtensa_got_loc_off: 0x70000000
        case .xtensa_got_loc_sz: 0x70000001
        case .sunw_auxiliary: 0x6000000d
        case .sunw_rtldinf: 0x6000000e
        case .sunw_filter: 0x6000000e
        case .sunw_cap: 0x60000010
        case .sunw_symtab: 0x60000011
        case .sunw_symsz: 0x60000012
        case .sunw_encoding: 0x60000013
        case .sunw_sortent: 0x60000013
        case .sunw_symsort: 0x60000014
        case .sunw_symsortsz: 0x60000015
        case .sunw_tlssort: 0x60000016
        case .sunw_tlssortsz: 0x60000017
        case .sunw_capinfo: 0x60000018
        case .sunw_strpad: 0x60000019
        case .sunw_capchain: 0x6000001a
        case .sunw_ldmach: 0x6000001b
        case .sunw_capchainent: 0x6000001d
        case .sunw_capchainsz: 0x6000001f
        case .sunw_parent: 0x60000021
        case .sunw_aslr: 0x60000023
        case .sunw_relax: 0x60000025
        case .sunw_nxheap: 0x60000029
        case .sunw_nxstack: 0x6000002b
        }
    }
}

extension DynamicTag: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: "DT_NULL"
        case .needed: "DT_NEEDED"
        case .pltrelsz: "DT_PLTRELSZ"
        case .pltgot: "DT_PLTGOT"
        case .hash: "DT_HASH"
        case .strtab: "DT_STRTAB"
        case .symtab: "DT_SYMTAB"
        case .rela: "DT_RELA"
        case .relasz: "DT_RELASZ"
        case .relaent: "DT_RELAENT"
        case .strsz: "DT_STRSZ"
        case .syment: "DT_SYMENT"
        case .`init`: "DT_INIT"
        case .fini: "DT_FINI"
        case .soname: "DT_SONAME"
        case .rpath: "DT_RPATH"
        case .symbolic: "DT_SYMBOLIC"
        case .rel: "DT_REL"
        case .relsz: "DT_RELSZ"
        case .relent: "DT_RELENT"
        case .pltrel: "DT_PLTREL"
        case .debug: "DT_DEBUG"
        case .textrel: "DT_TEXTREL"
        case .jmprel: "DT_JMPREL"
        case .bind_now: "DT_BIND_NOW"
        case .init_array: "DT_INIT_ARRAY"
        case .fini_array: "DT_FINI_ARRAY"
        case .init_arraysz: "DT_INIT_ARRAYSZ"
        case .fini_arraysz: "DT_FINI_ARRAYSZ"
        case .runpath: "DT_RUNPATH"
        case .flags: "DT_FLAGS"
        case .encoding: "DT_ENCODING"
        case .preinit_array: "DT_PREINIT_ARRAY"
        case .preinit_arraysz: "DT_PREINIT_ARRAYSZ"
        case .symtab_shndx: "DT_SYMTAB_SHNDX"
        case .relrsz: "DT_RELRSZ"
        case .relr: "DT_RELR"
        case .relrent: "DT_RELRENT"
        case .gnu_flags_1: "DT_GNU_FLAGS_1"
        case .gnu_prelinked: "DT_GNU_PRELINKED"
        case .gnu_conflictsz: "DT_GNU_CONFLICTSZ"
        case .gnu_liblistsz: "DT_GNU_LIBLISTSZ"
        case .checksum: "DT_CHECKSUM"
        case .pltpadsz: "DT_PLTPADSZ"
        case .moveent: "DT_MOVEENT"
        case .movesz: "DT_MOVESZ"
        case .feature: "DT_FEATURE"
        case .posflag_1: "DT_POSFLAG_1"
        case .syminsz: "DT_SYMINSZ"
        case .syminent: "DT_SYMINENT"
        case .gnu_hash: "DT_GNU_HASH"
        case .tlsdesc_plt: "DT_TLSDESC_PLT"
        case .tlsdesc_got: "DT_TLSDESC_GOT"
        case .gnu_conflict: "DT_GNU_CONFLICT"
        case .gnu_liblist: "DT_GNU_LIBLIST"
        case .config: "DT_CONFIG"
        case .depaudit: "DT_DEPAUDIT"
        case .audit: "DT_AUDIT"
        case .pltpad: "DT_PLTPAD"
        case .movetab: "DT_MOVETAB"
        case .syminfo: "DT_SYMINFO"
        case .relacount: "DT_RELACOUNT"
        case .relcount: "DT_RELCOUNT"
        case .flags_1: "DT_FLAGS_1"
        case .verdef: "DT_VERDEF"
        case .verdefnum: "DT_VERDEFNUM"
        case .verneed: "DT_VERNEED"
        case .verneednum: "DT_VERNEEDNUM"
        case .versym: "DT_VERSYM"
        case .auxiliary: "DT_AUXILIARY"
        case .used: "DT_USED"
        case .filter: "DT_FILTER"
        case .aarch64_bti_plt: "DT_AARCH64_BTI_PLT"
        case .aarch64_pac_plt: "DT_AARCH64_PAC_PLT"
        case .aarch64_variant_pcs: "DT_AARCH64_VARIANT_PCS"
        case .alpha_pltro: "DT_ALPHA_PLTRO"
        case .hp_load_map: "DT_HP_LOAD_MAP"
        case .hp_dld_flags: "DT_HP_DLD_FLAGS"
        case .hp_dld_hook: "DT_HP_DLD_HOOK"
        case .hp_ux10_init: "DT_HP_UX10_INIT"
        case .hp_ux10_initsz: "DT_HP_UX10_INITSZ"
        case .hp_preinit: "DT_HP_PREINIT"
        case .hp_preinitsz: "DT_HP_PREINITSZ"
        case .hp_needed: "DT_HP_NEEDED"
        case .hp_time_stamp: "DT_HP_TIME_STAMP"
        case .hp_checksum: "DT_HP_CHECKSUM"
        case .hp_gst_size: "DT_HP_GST_SIZE"
        case .hp_gst_version: "DT_HP_GST_VERSION"
        case .hp_gst_hashval: "DT_HP_GST_HASHVAL"
        case .hp_epltrel: "DT_HP_EPLTREL"
        case .hp_epltrelsz: "DT_HP_EPLTRELSZ"
        case .hp_filtered: "DT_HP_FILTERED"
        case .hp_filter_tls: "DT_HP_FILTER_TLS"
        case .hp_compat_filtered: "DT_HP_COMPAT_FILTERED"
        case .hp_lazyload: "DT_HP_LAZYLOAD"
        case .hp_bind_now_count: "DT_HP_BIND_NOW_COUNT"
        case .plt: "DT_PLT"
        case .plt_size: "DT_PLT_SIZE"
        case .dlt: "DT_DLT"
        case .dlt_size: "DT_DLT_SIZE"
        case .ia_64_plt_reserve: "DT_IA_64_PLT_RESERVE"
        case .ia_64_vms_subtype: "DT_IA_64_VMS_SUBTYPE"
        case .ia_64_vms_imgiocnt: "DT_IA_64_VMS_IMGIOCNT"
        case .ia_64_vms_lnkflags: "DT_IA_64_VMS_LNKFLAGS"
        case .ia_64_vms_vir_mem_blk_siz: "DT_IA_64_VMS_VIR_MEM_BLK_SIZ"
        case .ia_64_vms_ident: "DT_IA_64_VMS_IDENT"
        case .ia_64_vms_needed_ident: "DT_IA_64_VMS_NEEDED_IDENT"
        case .ia_64_vms_img_rela_cnt: "DT_IA_64_VMS_IMG_RELA_CNT"
        case .ia_64_vms_seg_rela_cnt: "DT_IA_64_VMS_SEG_RELA_CNT"
        case .ia_64_vms_fixup_rela_cnt: "DT_IA_64_VMS_FIXUP_RELA_CNT"
        case .ia_64_vms_fixup_needed: "DT_IA_64_VMS_FIXUP_NEEDED"
        case .ia_64_vms_symvec_cnt: "DT_IA_64_VMS_SYMVEC_CNT"
        case .ia_64_vms_xlated: "DT_IA_64_VMS_XLATED"
        case .ia_64_vms_stacksize: "DT_IA_64_VMS_STACKSIZE"
        case .ia_64_vms_unwindsz: "DT_IA_64_VMS_UNWINDSZ"
        case .ia_64_vms_unwind_codseg: "DT_IA_64_VMS_UNWIND_CODSEG"
        case .ia_64_vms_unwind_infoseg: "DT_IA_64_VMS_UNWIND_INFOSEG"
        case .ia_64_vms_linktime: "DT_IA_64_VMS_LINKTIME"
        case .ia_64_vms_seg_no: "DT_IA_64_VMS_SEG_NO"
        case .ia_64_vms_symvec_offset: "DT_IA_64_VMS_SYMVEC_OFFSET"
        case .ia_64_vms_symvec_seg: "DT_IA_64_VMS_SYMVEC_SEG"
        case .ia_64_vms_unwind_offset: "DT_IA_64_VMS_UNWIND_OFFSET"
        case .ia_64_vms_unwind_seg: "DT_IA_64_VMS_UNWIND_SEG"
        case .ia_64_vms_strtab_offset: "DT_IA_64_VMS_STRTAB_OFFSET"
        case .ia_64_vms_sysver_offset: "DT_IA_64_VMS_SYSVER_OFFSET"
        case .ia_64_vms_img_rela_off: "DT_IA_64_VMS_IMG_RELA_OFF"
        case .ia_64_vms_seg_rela_off: "DT_IA_64_VMS_SEG_RELA_OFF"
        case .ia_64_vms_fixup_rela_off: "DT_IA_64_VMS_FIXUP_RELA_OFF"
        case .ia_64_vms_pltgot_offset: "DT_IA_64_VMS_PLTGOT_OFFSET"
        case .ia_64_vms_pltgot_seg: "DT_IA_64_VMS_PLTGOT_SEG"
        case .ia_64_vms_fpmode: "DT_IA_64_VMS_FPMODE"
        case .mips_rld_version: "DT_MIPS_RLD_VERSION"
        case .mips_time_stamp: "DT_MIPS_TIME_STAMP"
        case .mips_ichecksum: "DT_MIPS_ICHECKSUM"
        case .mips_iversion: "DT_MIPS_IVERSION"
        case .mips_flags: "DT_MIPS_FLAGS"
        case .mips_base_address: "DT_MIPS_BASE_ADDRESS"
        case .mips_msym: "DT_MIPS_MSYM"
        case .mips_conflict: "DT_MIPS_CONFLICT"
        case .mips_liblist: "DT_MIPS_LIBLIST"
        case .mips_local_gotno: "DT_MIPS_LOCAL_GOTNO"
        case .mips_conflictno: "DT_MIPS_CONFLICTNO"
        case .mips_liblistno: "DT_MIPS_LIBLISTNO"
        case .mips_symtabno: "DT_MIPS_SYMTABNO"
        case .mips_unrefextno: "DT_MIPS_UNREFEXTNO"
        case .mips_gotsym: "DT_MIPS_GOTSYM"
        case .mips_hipageno: "DT_MIPS_HIPAGENO"
        case .mips_rld_map: "DT_MIPS_RLD_MAP"
        case .mips_delta_class: "DT_MIPS_DELTA_CLASS"
        case .mips_delta_class_no: "DT_MIPS_DELTA_CLASS_NO"
        case .mips_delta_instance: "DT_MIPS_DELTA_INSTANCE"
        case .mips_delta_instance_no: "DT_MIPS_DELTA_INSTANCE_NO"
        case .mips_delta_reloc: "DT_MIPS_DELTA_RELOC"
        case .mips_delta_reloc_no: "DT_MIPS_DELTA_RELOC_NO"
        case .mips_delta_sym: "DT_MIPS_DELTA_SYM"
        case .mips_delta_sym_no: "DT_MIPS_DELTA_SYM_NO"
        case .mips_delta_classsym: "DT_MIPS_DELTA_CLASSSYM"
        case .mips_delta_classsym_no: "DT_MIPS_DELTA_CLASSSYM_NO"
        case .mips_cxx_flags: "DT_MIPS_CXX_FLAGS"
        case .mips_pixie_init: "DT_MIPS_PIXIE_INIT"
        case .mips_symbol_lib: "DT_MIPS_SYMBOL_LIB"
        case .mips_localpage_gotidx: "DT_MIPS_LOCALPAGE_GOTIDX"
        case .mips_local_gotidx: "DT_MIPS_LOCAL_GOTIDX"
        case .mips_hidden_gotidx: "DT_MIPS_HIDDEN_GOTIDX"
        case .mips_protected_gotidx: "DT_MIPS_PROTECTED_GOTIDX"
        case .mips_options: "DT_MIPS_OPTIONS"
        case .mips_interface: "DT_MIPS_INTERFACE"
        case .mips_dynstr_align: "DT_MIPS_DYNSTR_ALIGN"
        case .mips_interface_size: "DT_MIPS_INTERFACE_SIZE"
        case .mips_rld_text_resolve_addr: "DT_MIPS_RLD_TEXT_RESOLVE_ADDR"
        case .mips_perf_suffix: "DT_MIPS_PERF_SUFFIX"
        case .mips_compact_size: "DT_MIPS_COMPACT_SIZE"
        case .mips_gp_value: "DT_MIPS_GP_VALUE"
        case .mips_aux_dynamic: "DT_MIPS_AUX_DYNAMIC"
        case .mips_pltgot: "DT_MIPS_PLTGOT"
        case .mips_rwplt: "DT_MIPS_RWPLT"
        case .mips_rld_map_rel: "DT_MIPS_RLD_MAP_REL"
        case .mips_xhash: "DT_MIPS_XHASH"
        case .nios2_gp: "DT_NIOS2_GP"
        case .ppc_got: "DT_PPC_GOT"
        case .ppc_opt: "DT_PPC_OPT"
        case .ppc64_glink: "DT_PPC64_GLINK"
        case .ppc64_opd: "DT_PPC64_OPD"
        case .ppc64_opdsz: "DT_PPC64_OPDSZ"
        case .ppc64_opt: "DT_PPC64_OPT"
        case .riscv_variant_cc: "DT_RISCV_VARIANT_CC"
        case .score_base_address: "DT_SCORE_BASE_ADDRESS"
        case .score_local_gotno: "DT_SCORE_LOCAL_GOTNO"
        case .score_symtabno: "DT_SCORE_SYMTABNO"
        case .score_gotsym: "DT_SCORE_GOTSYM"
        case .score_unrefextno: "DT_SCORE_UNREFEXTNO"
        case .score_hipageno: "DT_SCORE_HIPAGENO"
        case .sparc_register: "DT_SPARC_REGISTER"
        case .c6000_gsym_offset: "DT_C6000_GSYM_OFFSET"
        case .c6000_gstr_offset: "DT_C6000_GSTR_OFFSET"
        case .c6000_dsbt_base: "DT_C6000_DSBT_BASE"
        case .c6000_dsbt_size: "DT_C6000_DSBT_SIZE"
        case .c6000_preemptmap: "DT_C6000_PREEMPTMAP"
        case .c6000_dsbt_index: "DT_C6000_DSBT_INDEX"
//        case .vx_wrs_tls_data_start: "DT_VX_WRS_TLS_DATA_START"
//        case .vx_wrs_tls_data_size: "DT_VX_WRS_TLS_DATA_SIZE"
//        case .vx_wrs_tls_data_align: "DT_VX_WRS_TLS_DATA_ALIGN"
//        case .vx_wrs_tls_vars_start: "DT_VX_WRS_TLS_VARS_START"
//        case .vx_wrs_tls_vars_size: "DT_VX_WRS_TLS_VARS_SIZE"
        case .x86_64_plt: "DT_X86_64_PLT"
        case .x86_64_pltsz: "DT_X86_64_PLTSZ"
        case .x86_64_pltent: "DT_X86_64_PLTENT"
        case .xtensa_got_loc_off: "DT_XTENSA_GOT_LOC_OFF"
        case .xtensa_got_loc_sz: "DT_XTENSA_GOT_LOC_SZ"
        case .sunw_auxiliary: "DT_SUNW_AUXILIARY"
        case .sunw_rtldinf: "DT_SUNW_RTLDINF"
        case .sunw_filter: "DT_SUNW_FILTER"
        case .sunw_cap: "DT_SUNW_CAP"
        case .sunw_symtab: "DT_SUNW_SYMTAB"
        case .sunw_symsz: "DT_SUNW_SYMSZ"
        case .sunw_encoding: "DT_SUNW_ENCODING"
        case .sunw_sortent: "DT_SUNW_SORTENT"
        case .sunw_symsort: "DT_SUNW_SYMSORT"
        case .sunw_symsortsz: "DT_SUNW_SYMSORTSZ"
        case .sunw_tlssort: "DT_SUNW_TLSSORT"
        case .sunw_tlssortsz: "DT_SUNW_TLSSORTSZ"
        case .sunw_capinfo: "DT_SUNW_CAPINFO"
        case .sunw_strpad: "DT_SUNW_STRPAD"
        case .sunw_capchain: "DT_SUNW_CAPCHAIN"
        case .sunw_ldmach: "DT_SUNW_LDMACH"
        case .sunw_capchainent: "DT_SUNW_CAPCHAINENT"
        case .sunw_capchainsz: "DT_SUNW_CAPCHAINSZ"
        case .sunw_parent: "DT_SUNW_PARENT"
        case .sunw_aslr: "DT_SUNW_ASLR"
        case .sunw_relax: "DT_SUNW_RELAX"
        case .sunw_nxheap: "DT_SUNW_NXHEAP"
        case .sunw_nxstack: "DT_SUNW_NXSTACK"
        }
    }
}
