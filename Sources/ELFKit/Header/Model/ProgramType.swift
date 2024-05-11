//
//  ProgramType.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum ProgramType: CaseIterable {
    /// PT_NULL
    case null
    /// PT_LOAD
    case load
    /// PT_DYNAMIC
    case dynamic
    /// PT_INTERP
    case interp
    /// PT_NOTE
    case note
    /// PT_SHLIB
    case shlib
    /// PT_PHDR
    case phdr
    /// PT_TLS
    case tls
    /// PT_GNU_EH_FRAME
    case gnu_eh_frame
    /// PT_GNU_STACK
    case gnu_stack
    /// PT_GNU_RELRO
    case gnu_relro
    /// PT_GNU_PROPERTY
    case gnu_property
    /// PT_GNU_SFRAME
    case gnu_sframe
    /// PT_SUNW_UNWIND
    case sunw_unwind
    /// PT_SUNWBSS
    case sunwbss
    /// PT_SUNWSTACK
    case sunwstack
    /// PT_SUNWDTRACE
    case sunwdtrace
    /// PT_SUNWCAP
    case sunwcap
    /// PT_SUNW_EH_FRAME
    case sunw_eh_frame
    /// PT_OPENBSD_MUTABLE
    case openbsd_mutable
    /// PT_OPENBSD_RANDOMIZE
    case openbsd_randomize
    /// PT_OPENBSD_WXNEEDED
    case openbsd_wxneeded
    /// PT_OPENBSD_NOBTCFI
    case openbsd_nobtcfi
    /// PT_OPENBSD_SYSCALLS
    case openbsd_syscalls
    /// PT_OPENBSD_BOOTDATA
    case openbsd_bootdata
    /// PT_AARCH64_ARCHEXT
    case aarch64_archext
    /// PT_AARCH64_UNWIND
    case aarch64_unwind
    /// PT_AARCH64_MEMTAG_MTE
    case aarch64_memtag_mte
    /// PT_MIPS_REGINFO
    case mips_reginfo
    /// PT_MIPS_RTPROC
    case mips_rtproc
    /// PT_MIPS_OPTIONS
    case mips_options
    /// PT_MIPS_ABIFLAGS
    case mips_abiflags
    /// PT_ARM_ARCHEXT
    case arm_archext
    /// PT_ARM_EXIDX
    case arm_exidx
    /// PT_S390_PGSTE
    case s390_pgste
    /// PT_PARISC_ARCHEXT
    case parisc_archext
    /// PT_PARISC_UNWIND
    case parisc_unwind
    /// PT_PARISC_WEAKORDER
    case parisc_weakorder
    /// PT_IA_64_ARCHEXT
    case ia_64_archext
    /// PT_IA_64_UNWIND
    case ia_64_unwind
    /// PT_IA_64_HP_OPT_ANOT
    case ia_64_hp_oanot
    /// PT_IA_64_HP_HSL_ANOT
    case ia_64_hp_hsl_anot
    /// PT_IA_64_HP_STACK
    case ia_64_hp_stack
    /// PT_C6000_PHATTR
    case c6000_phattr
    /// PT_RISCV_ATTRIBUTES
    case riscv_attributes
    /// PT_HP_TLS
    case hp_tls
    /// PT_HP_CORE_NONE
    case hp_core_none
    /// PT_HP_CORE_VERSION
    case hp_core_version
    /// PT_HP_CORE_KERNEL
    case hp_core_kernel
    /// PT_HP_CORE_COMM
    case hp_core_comm
    /// PT_HP_CORE_PROC
    case hp_core_proc
    /// PT_HP_CORE_LOADABLE
    case hp_core_loadable
    /// PT_HP_CORE_STACK
    case hp_core_stack
    /// PT_HP_CORE_SHM
    case hp_core_shm
    /// PT_HP_CORE_MMF
    case hp_core_mmf
    /// PT_HP_PARALLEL
    case hp_parallel
    /// PT_HP_FASTBIND
    case hp_fastbind
    /// PT_HP_OPT_ANNOT
    case hp_oannot
    /// PT_HP_HSL_ANNOT
    case hp_hsl_annot
    /// PT_HP_STACK
    case hp_stack
    /// PT_HP_CORE_UTSNAME
    case hp_core_utsname
    /// PT_SPU_INFO
    case spu_info
}

extension ProgramType/*: RawRepresentable*/ {
    public typealias RawValue = UInt32

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        switch rawValue {
        case 0: self = .null
        case 1: self = .load
        case 2: self = .dynamic
        case 3: self = .interp
        case 4: self = .note
        case 5: self = .shlib
        case 6: self = .phdr
        case 7: self = .tls

        default:
            switch (osabi, machine, rawValue) {
            case (.solaris, _, 0x6464e550): self = .sunw_unwind
            case (.solaris, _, 0x6ffffffa): self = .sunwbss
            case (.solaris, _, 0x6ffffffb): self = .sunwstack
            case (.solaris, _, 0x6ffffffc): self = .sunwdtrace
            case (.solaris, _, 0x6ffffffd): self = .sunwcap
            case (.solaris, _, 0x6474e550): self = .sunw_eh_frame

            case (_, _, 0x6474e550): self = .gnu_eh_frame
            case (_, _, 0x6474e551): self = .gnu_stack
            case (_, _, 0x6474e552): self = .gnu_relro
            case (_, _, 0x6474e553): self = .gnu_property
            case (_, _, 0x6474e554): self = .gnu_sframe

            case (_, _, 0x65a3dbe5): self = .openbsd_mutable
            case (_, _, 0x65a3dbe6): self = .openbsd_randomize
            case (_, _, 0x65a3dbe7): self = .openbsd_wxneeded
            case (_, _, 0x65a3dbe8): self = .openbsd_nobtcfi
            case (_, _, 0x65a3dbe9): self = .openbsd_syscalls
            case (_, _, 0x65a41be6): self = .openbsd_bootdata

            case (_, .aarch64, 0x70000000): self = .aarch64_archext
            case (_, .aarch64, 0x70000001): self = .aarch64_unwind
            case (_, .aarch64, 0x70000002): self = .aarch64_memtag_mte


            case (_, .arm, 0x70000000): self = .arm_archext
            case (_, .arm, 0x70000001): self = .arm_exidx

            case _ where [.mips, .mips_rs3_le].contains(machine):
                switch rawValue {
                case 0x70000000: self = .mips_reginfo
                case 0x70000001: self = .mips_rtproc
                case 0x70000002: self = .mips_options
                case 0x70000003: self = .mips_abiflags
                default: return nil
                }

            case (_, .parisc, 0x70000000): self = .parisc_archext
            case (_, .parisc, 0x70000001): self = .parisc_unwind
            case (_, .parisc, 0x70000002): self = .parisc_weakorder

            case (_, .ia_64, 0x70000000): self = .ia_64_archext
            case (_, .ia_64, 0x70000001): self = .ia_64_unwind

            case (_, .ti_c6000, 0x70000000): self = .c6000_phattr

            case (_, .s390, 0x70000000): self = .s390_pgste

            case (_, .riscv, 0x70000003): self = .riscv_attributes

            case (_, .spu, 0x70000000): self = .spu_info

            case (.hpux, .parisc, 0x60000000): self = .hp_tls
            case (.hpux, .parisc, 0x60000001): self = .hp_core_none
            case (.hpux, .parisc, 0x60000002): self = .hp_core_version
            case (.hpux, .parisc, 0x60000003): self = .hp_core_kernel
            case (.hpux, .parisc, 0x60000004): self = .hp_core_comm
            case (.hpux, .parisc, 0x60000005): self = .hp_core_proc
            case (.hpux, .parisc, 0x60000006): self = .hp_core_loadable
            case (.hpux, .parisc, 0x60000007): self = .hp_core_stack
            case (.hpux, .parisc, 0x60000008): self = .hp_core_shm
            case (.hpux, .parisc, 0x60000009): self = .hp_core_mmf
            case (.hpux, .parisc, 0x60000010): self = .hp_parallel
            case (.hpux, .parisc, 0x60000011): self = .hp_fastbind
            case (.hpux, .parisc, 0x60000012): self = .hp_oannot
            case (.hpux, .parisc, 0x60000013): self = .hp_hsl_annot
            case (.hpux, .parisc, 0x60000014): self = .hp_stack
            case (.hpux, .parisc, 0x60000015): self = .hp_core_utsname

            case (.hpux, .ia_64, 0x60000000): self = .hp_tls
            case (.hpux, .ia_64, 0x60000012): self = .ia_64_hp_oanot
            case (.hpux, .ia_64, 0x60000013): self = .ia_64_hp_hsl_anot
            case (.hpux, .ia_64, 0x60000014): self = .ia_64_hp_stack

            default: return nil
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .null: 0
        case .load: 1
        case .dynamic: 2
        case .interp: 3
        case .note: 4
        case .shlib: 5
        case .phdr: 6
        case .tls: 7
        case .gnu_eh_frame: 0x6474e550
        case .gnu_stack: 0x6474e551
        case .gnu_relro: 0x6474e552
        case .gnu_property: 0x6474e553
        case .gnu_sframe: 0x6474e554
        case .sunw_unwind: 0x6464e550
        case .sunwbss: 0x6ffffffa
        case .sunwstack: 0x6ffffffb
        case .sunwdtrace: 0x6ffffffc
        case .sunwcap: 0x6ffffffd
        case .sunw_eh_frame: 0x6474e550
        case .openbsd_mutable: 0x65a3dbe5
        case .openbsd_randomize: 0x65a3dbe6
        case .openbsd_wxneeded: 0x65a3dbe7
        case .openbsd_nobtcfi: 0x65a3dbe8
        case .openbsd_syscalls: 0x65a3dbe9
        case .openbsd_bootdata: 0x65a41be6
        case .aarch64_archext: 0x70000000
        case .aarch64_unwind: 0x70000001
        case .aarch64_memtag_mte: 0x70000002
        case .mips_reginfo: 0x70000000
        case .mips_rtproc: 0x70000001
        case .mips_options: 0x70000002
        case .mips_abiflags: 0x70000003
        case .arm_archext: 0x70000000
        case .arm_exidx: 0x70000001
        case .s390_pgste: 0x70000000
        case .parisc_archext: 0x70000000
        case .parisc_unwind: 0x70000001
        case .parisc_weakorder: 0x70000002
        case .ia_64_archext: 0x70000000
        case .ia_64_unwind: 0x70000001
        case .ia_64_hp_oanot: 0x60000012
        case .ia_64_hp_hsl_anot: 0x60000013
        case .ia_64_hp_stack: 0x60000014
        case .c6000_phattr: 0x70000000
        case .riscv_attributes: 0x70000003
        case .hp_tls: 0x60000000
        case .hp_core_none: 0x60000001
        case .hp_core_version: 0x60000002
        case .hp_core_kernel: 0x60000003
        case .hp_core_comm: 0x60000004
        case .hp_core_proc: 0x60000005
        case .hp_core_loadable: 0x60000006
        case .hp_core_stack: 0x60000007
        case .hp_core_shm: 0x60000008
        case .hp_core_mmf: 0x60000009
        case .hp_parallel: 0x60000010
        case .hp_fastbind: 0x60000011
        case .hp_oannot: 0x60000012
        case .hp_hsl_annot: 0x60000013
        case .hp_stack: 0x60000014
        case .hp_core_utsname: 0x60000015
        case .spu_info: 0x70000000
        }
    }
}

extension ProgramType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: "PT_NULL"
        case .load: "PT_LOAD"
        case .dynamic: "PT_DYNAMIC"
        case .interp: "PT_INTERP"
        case .note: "PT_NOTE"
        case .shlib: "PT_SHLIB"
        case .phdr: "PT_PHDR"
        case .tls: "PT_TLS"
        case .gnu_eh_frame: "PT_GNU_EH_FRAME"
        case .gnu_stack: "PT_GNU_STACK"
        case .gnu_relro: "PT_GNU_RELRO"
        case .gnu_property: "PT_GNU_PROPERTY"
        case .gnu_sframe: "PT_GNU_SFRAME"
        case .sunw_unwind: "PT_SUNW_UNWIND"
        case .sunwbss: "PT_SUNWBSS"
        case .sunwstack: "PT_SUNWSTACK"
        case .sunwdtrace: "PT_SUNWDTRACE"
        case .sunwcap: "PT_SUNWCAP"
        case .sunw_eh_frame: "PT_SUNW_EH_FRAME"
        case .openbsd_mutable: "PT_OPENBSD_MUTABLE"
        case .openbsd_randomize: "PT_OPENBSD_RANDOMIZE"
        case .openbsd_wxneeded: "PT_OPENBSD_WXNEEDED"
        case .openbsd_nobtcfi: "PT_OPENBSD_NOBTCFI"
        case .openbsd_syscalls: "PT_OPENBSD_SYSCALLS"
        case .openbsd_bootdata: "PT_OPENBSD_BOOTDATA"
        case .aarch64_archext: "PT_AARCH64_ARCHEXT"
        case .aarch64_unwind: "PT_AARCH64_UNWIND"
        case .aarch64_memtag_mte: "PT_AARCH64_MEMTAG_MTE"
        case .mips_reginfo: "PT_MIPS_REGINFO"
        case .mips_rtproc: "PT_MIPS_RTPROC"
        case .mips_options: "PT_MIPS_OPTIONS"
        case .mips_abiflags: "PT_MIPS_ABIFLAGS"
        case .arm_archext: "PT_ARM_ARCHEXT"
        case .arm_exidx: "PT_ARM_EXIDX"
        case .s390_pgste: "PT_S390_PGSTE"
        case .parisc_archext: "PT_PARISC_ARCHEXT"
        case .parisc_unwind: "PT_PARISC_UNWIND"
        case .parisc_weakorder: "PT_PARISC_WEAKORDER"
        case .ia_64_archext: "PT_IA_64_ARCHEXT"
        case .ia_64_unwind: "PT_IA_64_UNWIND"
        case .ia_64_hp_oanot: "PT_IA_64_HP_OPT_ANOT"
        case .ia_64_hp_hsl_anot: "PT_IA_64_HP_HSL_ANOT"
        case .ia_64_hp_stack: "PT_IA_64_HP_STACK"
        case .c6000_phattr: "PT_C6000_PHATTR"
        case .riscv_attributes: "PT_RISCV_ATTRIBUTES"
        case .hp_tls: "PT_HP_TLS"
        case .hp_core_none: "PT_HP_CORE_NONE"
        case .hp_core_version: "PT_HP_CORE_VERSION"
        case .hp_core_kernel: "PT_HP_CORE_KERNEL"
        case .hp_core_comm: "PT_HP_CORE_COMM"
        case .hp_core_proc: "PT_HP_CORE_PROC"
        case .hp_core_loadable: "PT_HP_CORE_LOADABLE"
        case .hp_core_stack: "PT_HP_CORE_STACK"
        case .hp_core_shm: "PT_HP_CORE_SHM"
        case .hp_core_mmf: "PT_HP_CORE_MMF"
        case .hp_parallel: "PT_HP_PARALLEL"
        case .hp_fastbind: "PT_HP_FASTBIND"
        case .hp_oannot: "PT_HP_OPT_ANNOT"
        case .hp_hsl_annot: "PT_HP_HSL_ANNOT"
        case .hp_stack: "PT_HP_STACK"
        case .hp_core_utsname: "PT_HP_CORE_UTSNAME"
        case .spu_info: "PT_SPU_INFO"
        }
    }
}

extension ProgramType {
    public var isOSSpecific: Bool {
        let PT_LOOS = 0x60000000
        let PT_HIOS = 0x6fffffff
        return PT_LOOS <= rawValue && rawValue <= PT_HIOS
    }

    public var isProcessorSpecific: Bool {
        let PT_LOPROC = 0x70000000
        let PT_HIPROC = 0x7fffffff
        return PT_LOPROC <= rawValue && rawValue <= PT_HIPROC
    }
}
