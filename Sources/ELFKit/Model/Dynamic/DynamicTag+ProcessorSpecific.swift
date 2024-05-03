//
//  DynamicTag+ProcessorSpecific.swift
//
//
//  Created by p-x9 on 2024/05/03
//  
//

import Foundation
import ELFKitC

extension DynamicTag {
    public struct ProcessorSpecific: RawRepresentable {
        public typealias RawValue = UInt64
        public var rawValue: RawValue

        public var aarch64: AARCH64? {
            .init(rawValue: rawValue)
        }

        public var arm: ARM? {
            .init(rawValue: rawValue)
        }

        public var sparc: SPARC? {
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

extension DynamicTag.ProcessorSpecific: CustomStringConvertible {
    public var description: String {
        [
            aarch64?.description,
            arm?.description,
            sparc?.description,
            mips?.description,
        ]
            .compactMap { $0 }
            .description
    }
}

// MARK: - AARCH64
extension DynamicTag {
    public enum AARCH64: CaseIterable {
        /// DT_AARCH64_BTI_PLT
        case bti_plt
        /// DT_AARCH64_PAC_PLT
        case pac_plt
        /// DT_AARCH64_VARIANT_PCS
        case variant_pcs
    }
}

extension DynamicTag.AARCH64: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DT_AARCH64_BTI_PLT): self = .bti_plt
        case RawValue(DT_AARCH64_PAC_PLT): self = .pac_plt
        case RawValue(DT_AARCH64_VARIANT_PCS): self = .variant_pcs
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .bti_plt: RawValue(DT_AARCH64_BTI_PLT)
        case .pac_plt: RawValue(DT_AARCH64_PAC_PLT)
        case .variant_pcs: RawValue(DT_AARCH64_VARIANT_PCS)
        }
    }
}

extension DynamicTag.AARCH64: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bti_plt: "DT_AARCH64_BTI_PLT"
        case .pac_plt: "DT_AARCH64_PAC_PLT"
        case .variant_pcs: "DT_AARCH64_VARIANT_PCS"
        }
    }
}

// MARK: - ARM
extension DynamicTag {
    public enum ARM: CaseIterable {
        /// DT_ARM_SYMTABSZ
        case symtabsz
        /// DT_ARM_PREEMPTMAP
        case preemptmap
    }
}

extension DynamicTag.ARM: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DT_ARM_SYMTABSZ): self = .symtabsz
        case RawValue(DT_ARM_PREEMPTMAP): self = .preemptmap
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .symtabsz: RawValue(DT_ARM_SYMTABSZ)
        case .preemptmap: RawValue(DT_ARM_PREEMPTMAP)
        }
    }
}

extension DynamicTag.ARM: CustomStringConvertible {
    public var description: String {
        switch self {
        case .symtabsz: "DT_ARM_SYMTABSZ"
        case .preemptmap: "DT_ARM_PREEMPTMAP"
        }
    }
}

// MARK: - SPARC
extension DynamicTag {
    public enum SPARC: CaseIterable {
        /// DT_SPARC_REGISTER
        case register
    }
}

extension DynamicTag.SPARC: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DT_SPARC_REGISTER): self = .register
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .register: RawValue(DT_SPARC_REGISTER)
        }
    }
}

extension DynamicTag.SPARC: CustomStringConvertible {
    public var description: String {
        switch self {
        case .register: "DT_SPARC_REGISTER"
        }
    }
}

// MARK: - MIPS
extension DynamicTag {
    public enum MIPS: CaseIterable {
        /// DT_MIPS_RLD_VERSION
        case rld_version
        /// DT_MIPS_TIME_STAMP
        case time_stamp
        /// DT_MIPS_ICHECKSUM
        case ichecksum
        /// DT_MIPS_IVERSION
        case iversion
        /// DT_MIPS_FLAGS
        case flags
        /// DT_MIPS_BASE_ADDRESS
        case base_address
        /// DT_MIPS_CONFLICT
        case conflict
        /// DT_MIPS_LIBLIST
        case liblist
        /// DT_MIPS_LOCAL_GOTNO
        case local_gotno
        /// DT_MIPS_CONFLICTNO
        case conflictno
        /// DT_MIPS_LIBLISTNO
        case liblistno
        /// DT_MIPS_SYMTABNO
        case symtabno
        /// DT_MIPS_UNREFEXTNO
        case unrefextno
        /// DT_MIPS_GOTSYM
        case gotsym
        /// DT_MIPS_HIPAGENO
        case hipageno
        /// DT_MIPS_RLD_MAP
        case rld_map
        /// DT_MIPS_DELTA_CLASS
        case delta_class
        /// DT_MIPS_DELTA_CLASS_NO
        case delta_class_no
        /// DT_MIPS_DELTA_INSTANCE
        case delta_instance
        /// DT_MIPS_DELTA_INSTANCE_NO
        case delta_instance_no
        /// DT_MIPS_DELTA_RELOC
        case delta_reloc
        /// DT_MIPS_DELTA_RELOC_NO
        case delta_reloc_no
        /// DT_MIPS_DELTA_SYM
        case delta_sym
        /// DT_MIPS_DELTA_SYM_NO
        case delta_sym_no
        /// DT_MIPS_DELTA_CLASSSYM
        case delta_classsym
        /// DT_MIPS_DELTA_CLASSSYM_NO
        case delta_classsym_no
        /// DT_MIPS_CXX_FLAGS
        case cxx_flags
        /// DT_MIPS_PIXIE_INIT
        case pixie_init
        /// DT_MIPS_SYMBOL_LIB
        case symbol_lib
        /// DT_MIPS_LOCALPAGE_GOTIDX
        case localpage_gotidx
        /// DT_MIPS_LOCAL_GOTIDX
        case local_gotidx
        /// DT_MIPS_HIDDEN_GOTIDX
        case hidden_gotidx
        /// DT_MIPS_PROTECTED_GOTIDX
        case protected_gotidx
        /// DT_MIPS_OPTIONS
        case options
        /// DT_MIPS_INTERFACE
        case interface
        /// DT_MIPS_DYNSTR_ALIGN
        case dynstr_align
        /// DT_MIPS_INTERFACE_SIZE
        case interface_size
        /// DT_MIPS_RLD_TEXT_RESOLVE_ADDR
        case rld_text_resolve_addr
        /// DT_MIPS_PERF_SUFFIX
        case perf_suffix
        /// DT_MIPS_COMPACT_SIZE
        case compact_size
        /// DT_MIPS_GP_VALUE
        case gp_value
        /// DT_MIPS_AUX_DYNAMIC
        case aux_dynamic
        /// DT_MIPS_PLTGOT
        case pltgot
        /// DT_MIPS_RLD_OBJ_UPDATE
        case rld_obj_update
        /// DT_MIPS_RWPLT
        case rwplt
        /// DT_MIPS_RLD_MAP_REL
        case rld_map_rel
    }
}

extension DynamicTag.MIPS: RawRepresentable {
    public typealias RawValue = UInt64

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DT_MIPS_RLD_VERSION): self = .rld_version
        case RawValue(DT_MIPS_TIME_STAMP): self = .time_stamp
        case RawValue(DT_MIPS_ICHECKSUM): self = .ichecksum
        case RawValue(DT_MIPS_IVERSION): self = .iversion
        case RawValue(DT_MIPS_FLAGS): self = .flags
        case RawValue(DT_MIPS_BASE_ADDRESS): self = .base_address
        case RawValue(DT_MIPS_CONFLICT): self = .conflict
        case RawValue(DT_MIPS_LIBLIST): self = .liblist
        case RawValue(DT_MIPS_LOCAL_GOTNO): self = .local_gotno
        case RawValue(DT_MIPS_CONFLICTNO): self = .conflictno
        case RawValue(DT_MIPS_LIBLISTNO): self = .liblistno
        case RawValue(DT_MIPS_SYMTABNO): self = .symtabno
        case RawValue(DT_MIPS_UNREFEXTNO): self = .unrefextno
        case RawValue(DT_MIPS_GOTSYM): self = .gotsym
        case RawValue(DT_MIPS_HIPAGENO): self = .hipageno
        case RawValue(DT_MIPS_RLD_MAP): self = .rld_map
        case RawValue(DT_MIPS_DELTA_CLASS): self = .delta_class
        case RawValue(DT_MIPS_DELTA_CLASS_NO): self = .delta_class_no
        case RawValue(DT_MIPS_DELTA_INSTANCE): self = .delta_instance
        case RawValue(DT_MIPS_DELTA_INSTANCE_NO): self = .delta_instance_no
        case RawValue(DT_MIPS_DELTA_RELOC): self = .delta_reloc
        case RawValue(DT_MIPS_DELTA_RELOC_NO): self = .delta_reloc_no
        case RawValue(DT_MIPS_DELTA_SYM): self = .delta_sym
        case RawValue(DT_MIPS_DELTA_SYM_NO): self = .delta_sym_no
        case RawValue(DT_MIPS_DELTA_CLASSSYM): self = .delta_classsym
        case RawValue(DT_MIPS_DELTA_CLASSSYM_NO): self = .delta_classsym_no
        case RawValue(DT_MIPS_CXX_FLAGS): self = .cxx_flags
        case RawValue(DT_MIPS_PIXIE_INIT): self = .pixie_init
        case RawValue(DT_MIPS_SYMBOL_LIB): self = .symbol_lib
        case RawValue(DT_MIPS_LOCALPAGE_GOTIDX): self = .localpage_gotidx
        case RawValue(DT_MIPS_LOCAL_GOTIDX): self = .local_gotidx
        case RawValue(DT_MIPS_HIDDEN_GOTIDX): self = .hidden_gotidx
        case RawValue(DT_MIPS_PROTECTED_GOTIDX): self = .protected_gotidx
        case RawValue(DT_MIPS_OPTIONS): self = .options
        case RawValue(DT_MIPS_INTERFACE): self = .interface
        case RawValue(DT_MIPS_DYNSTR_ALIGN): self = .dynstr_align
        case RawValue(DT_MIPS_INTERFACE_SIZE): self = .interface_size
        case RawValue(DT_MIPS_RLD_TEXT_RESOLVE_ADDR): self = .rld_text_resolve_addr
        case RawValue(DT_MIPS_PERF_SUFFIX): self = .perf_suffix
        case RawValue(DT_MIPS_COMPACT_SIZE): self = .compact_size
        case RawValue(DT_MIPS_GP_VALUE): self = .gp_value
        case RawValue(DT_MIPS_AUX_DYNAMIC): self = .aux_dynamic
        case RawValue(DT_MIPS_PLTGOT): self = .pltgot
        case RawValue(DT_MIPS_RLD_OBJ_UPDATE): self = .rld_obj_update
        case RawValue(DT_MIPS_RWPLT): self = .rwplt
        case RawValue(DT_MIPS_RLD_MAP_REL): self = .rld_map_rel
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .rld_version: RawValue(DT_MIPS_RLD_VERSION)
        case .time_stamp: RawValue(DT_MIPS_TIME_STAMP)
        case .ichecksum: RawValue(DT_MIPS_ICHECKSUM)
        case .iversion: RawValue(DT_MIPS_IVERSION)
        case .flags: RawValue(DT_MIPS_FLAGS)
        case .base_address: RawValue(DT_MIPS_BASE_ADDRESS)
        case .conflict: RawValue(DT_MIPS_CONFLICT)
        case .liblist: RawValue(DT_MIPS_LIBLIST)
        case .local_gotno: RawValue(DT_MIPS_LOCAL_GOTNO)
        case .conflictno: RawValue(DT_MIPS_CONFLICTNO)
        case .liblistno: RawValue(DT_MIPS_LIBLISTNO)
        case .symtabno: RawValue(DT_MIPS_SYMTABNO)
        case .unrefextno: RawValue(DT_MIPS_UNREFEXTNO)
        case .gotsym: RawValue(DT_MIPS_GOTSYM)
        case .hipageno: RawValue(DT_MIPS_HIPAGENO)
        case .rld_map: RawValue(DT_MIPS_RLD_MAP)
        case .delta_class: RawValue(DT_MIPS_DELTA_CLASS)
        case .delta_class_no: RawValue(DT_MIPS_DELTA_CLASS_NO)
        case .delta_instance: RawValue(DT_MIPS_DELTA_INSTANCE)
        case .delta_instance_no: RawValue(DT_MIPS_DELTA_INSTANCE_NO)
        case .delta_reloc: RawValue(DT_MIPS_DELTA_RELOC)
        case .delta_reloc_no: RawValue(DT_MIPS_DELTA_RELOC_NO)
        case .delta_sym: RawValue(DT_MIPS_DELTA_SYM)
        case .delta_sym_no: RawValue(DT_MIPS_DELTA_SYM_NO)
        case .delta_classsym: RawValue(DT_MIPS_DELTA_CLASSSYM)
        case .delta_classsym_no: RawValue(DT_MIPS_DELTA_CLASSSYM_NO)
        case .cxx_flags: RawValue(DT_MIPS_CXX_FLAGS)
        case .pixie_init: RawValue(DT_MIPS_PIXIE_INIT)
        case .symbol_lib: RawValue(DT_MIPS_SYMBOL_LIB)
        case .localpage_gotidx: RawValue(DT_MIPS_LOCALPAGE_GOTIDX)
        case .local_gotidx: RawValue(DT_MIPS_LOCAL_GOTIDX)
        case .hidden_gotidx: RawValue(DT_MIPS_HIDDEN_GOTIDX)
        case .protected_gotidx: RawValue(DT_MIPS_PROTECTED_GOTIDX)
        case .options: RawValue(DT_MIPS_OPTIONS)
        case .interface: RawValue(DT_MIPS_INTERFACE)
        case .dynstr_align: RawValue(DT_MIPS_DYNSTR_ALIGN)
        case .interface_size: RawValue(DT_MIPS_INTERFACE_SIZE)
        case .rld_text_resolve_addr: RawValue(DT_MIPS_RLD_TEXT_RESOLVE_ADDR)
        case .perf_suffix: RawValue(DT_MIPS_PERF_SUFFIX)
        case .compact_size: RawValue(DT_MIPS_COMPACT_SIZE)
        case .gp_value: RawValue(DT_MIPS_GP_VALUE)
        case .aux_dynamic: RawValue(DT_MIPS_AUX_DYNAMIC)
        case .pltgot: RawValue(DT_MIPS_PLTGOT)
        case .rld_obj_update: RawValue(DT_MIPS_RLD_OBJ_UPDATE)
        case .rwplt: RawValue(DT_MIPS_RWPLT)
        case .rld_map_rel: RawValue(DT_MIPS_RLD_MAP_REL)
        }
    }
}


extension DynamicTag.MIPS: CustomStringConvertible {
    public var description: String {
        switch self {
        case .rld_version: "DT_MIPS_RLD_VERSION"
        case .time_stamp: "DT_MIPS_TIME_STAMP"
        case .ichecksum: "DT_MIPS_ICHECKSUM"
        case .iversion: "DT_MIPS_IVERSION"
        case .flags: "DT_MIPS_FLAGS"
        case .base_address: "DT_MIPS_BASE_ADDRESS"
        case .conflict: "DT_MIPS_CONFLICT"
        case .liblist: "DT_MIPS_LIBLIST"
        case .local_gotno: "DT_MIPS_LOCAL_GOTNO"
        case .conflictno: "DT_MIPS_CONFLICTNO"
        case .liblistno: "DT_MIPS_LIBLISTNO"
        case .symtabno: "DT_MIPS_SYMTABNO"
        case .unrefextno: "DT_MIPS_UNREFEXTNO"
        case .gotsym: "DT_MIPS_GOTSYM"
        case .hipageno: "DT_MIPS_HIPAGENO"
        case .rld_map: "DT_MIPS_RLD_MAP"
        case .delta_class: "DT_MIPS_DELTA_CLASS"
        case .delta_class_no: "DT_MIPS_DELTA_CLASS_NO"
        case .delta_instance: "DT_MIPS_DELTA_INSTANCE"
        case .delta_instance_no: "DT_MIPS_DELTA_INSTANCE_NO"
        case .delta_reloc: "DT_MIPS_DELTA_RELOC"
        case .delta_reloc_no: "DT_MIPS_DELTA_RELOC_NO"
        case .delta_sym: "DT_MIPS_DELTA_SYM"
        case .delta_sym_no: "DT_MIPS_DELTA_SYM_NO"
        case .delta_classsym: "DT_MIPS_DELTA_CLASSSYM"
        case .delta_classsym_no: "DT_MIPS_DELTA_CLASSSYM_NO"
        case .cxx_flags: "DT_MIPS_CXX_FLAGS"
        case .pixie_init: "DT_MIPS_PIXIE_INIT"
        case .symbol_lib: "DT_MIPS_SYMBOL_LIB"
        case .localpage_gotidx: "DT_MIPS_LOCALPAGE_GOTIDX"
        case .local_gotidx: "DT_MIPS_LOCAL_GOTIDX"
        case .hidden_gotidx: "DT_MIPS_HIDDEN_GOTIDX"
        case .protected_gotidx: "DT_MIPS_PROTECTED_GOTIDX"
        case .options: "DT_MIPS_OPTIONS"
        case .interface: "DT_MIPS_INTERFACE"
        case .dynstr_align: "DT_MIPS_DYNSTR_ALIGN"
        case .interface_size: "DT_MIPS_INTERFACE_SIZE"
        case .rld_text_resolve_addr: "DT_MIPS_RLD_TEXT_RESOLVE_ADDR"
        case .perf_suffix: "DT_MIPS_PERF_SUFFIX"
        case .compact_size: "DT_MIPS_COMPACT_SIZE"
        case .gp_value: "DT_MIPS_GP_VALUE"
        case .aux_dynamic: "DT_MIPS_AUX_DYNAMIC"
        case .pltgot: "DT_MIPS_PLTGOT"
        case .rld_obj_update: "DT_MIPS_RLD_OBJ_UPDATE"
        case .rwplt: "DT_MIPS_RWPLT"
        case .rld_map_rel: "DT_MIPS_RLD_MAP_REL"
        }
    }
}
