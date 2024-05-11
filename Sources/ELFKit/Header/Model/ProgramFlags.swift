//
//  ProgramFlags.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public struct ProgramFlags: ConditionalBitFlags {
    public typealias RawValue = UInt32

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

extension ProgramFlags {
    public var isOSSpecific: Bool {
        let PF_MASKOS = 0x0ff00000
        return (rawValue & numericCast(PF_MASKOS)) > 0
    }

    public var isProcessorSpecific: Bool {
        let PF_MASKPROC = 0xf0000000
        return (rawValue & numericCast(PF_MASKPROC)) > 0
    }
}

extension ProgramFlags {
    public enum Bit: CaseIterable {
        /// PF_X
        case x
        /// PF_W
        case w
        /// PF_R
        case r
        /// PF_ARM_SB
        case arm_sb
        /// PF_ARM_PI
        case arm_pi
        /// PF_ARM_ABS
        case arm_abs
        /// PF_HP_CODE
        case hp_code
        /// PF_HP_MODIFY
        case hp_modify
        /// PF_HP_PAGE_SIZE
        case hp_page_size
        /// PF_HP_FAR_SHARED
        case hp_far_shared
        /// PF_HP_NEAR_SHARED
        case hp_near_shared
        /// PF_HP_LAZYSWAP
        case hp_lazyswap
        /// PF_HP_CODE_DEPR
        case hp_code_depr
        /// PF_HP_MODIFY_DEPR
        case hp_modify_depr
        /// PF_HP_LAZYSWAP_DEPR
        case hp_lazyswap_depr
        /// PF_PARISC_SBP
        case parisc_sbp
        /// PF_HP_SBP
        case hp_sbp
        /// PF_IA_64_NORECOV
        case ia_64_norecov
        /// PF_PPC_VLE
        case ppc_vle
        /// PF_OVERLAY
        case overlay
    }
}

extension ProgramFlags.Bit: RawRepresentable {
    public typealias RawValue = UInt32

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
        case 0x00000001: self = .x
        case 0x00000002: self = .w
        case 0x00000004: self = .r
        default:
            switch (osabi, machine, rawValue) {
            case (_, .arm, 0x10000000): self = .arm_sb
            case (_, .arm, 0x20000000): self = .arm_pi
            case (_, .arm, 0x40000000): self = .arm_abs
            case (.hpux, _, 0x01000000): self = .hp_code
            case (.hpux, _, 0x02000000): self = .hp_modify
            case (.hpux, _, 0x00100000): self = .hp_page_size
            case (.hpux, _, 0x00200000): self = .hp_far_shared
            case (.hpux, _, 0x00400000): self = .hp_near_shared
            case (.hpux, _, 0x04000000): self = .hp_lazyswap
            case (.hpux, _, 0x01000000): self = .hp_code_depr
            case (.hpux, _, 0x02000000): self = .hp_modify_depr
            case (.hpux, _, 0x04000000): self = .hp_lazyswap_depr
            case (.hpux, .parisc, 0x08000000): self = .parisc_sbp
            case (.hpux, _, 0x08000000): self = .hp_sbp
            case (_, .ia_64, 0x80000000): self = .ia_64_norecov
            case (_, .ppc, 0x10000000): self = .ppc_vle
            case (_, .spu, 0x08000000): self = .overlay
            default: return nil
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .x: 0x00000001
        case .w: 0x00000002
        case .r: 0x00000004
        case .arm_sb: 0x10000000
        case .arm_pi: 0x20000000
        case .arm_abs: 0x40000000
        case .hp_code: 0x01000000
        case .hp_modify: 0x02000000
        case .hp_page_size: 0x00100000
        case .hp_far_shared: 0x00200000
        case .hp_near_shared: 0x00400000
        case .hp_lazyswap: 0x04000000
        case .hp_code_depr: 0x01000000
        case .hp_modify_depr: 0x02000000
        case .hp_lazyswap_depr: 0x04000000
        case .parisc_sbp: 0x08000000
        case .hp_sbp: 0x08000000
        case .ia_64_norecov: 0x80000000
        case .ppc_vle: 0x10000000
        case .overlay: 0x08000000
        }
    }
}

extension ProgramFlags.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .x: "PF_X"
        case .w: "PF_W"
        case .r: "PF_R"
        case .arm_sb: "PF_ARM_SB"
        case .arm_pi: "PF_ARM_PI"
        case .arm_abs: "PF_ARM_ABS"
        case .hp_code: "PF_HP_CODE"
        case .hp_modify: "PF_HP_MODIFY"
        case .hp_page_size: "PF_HP_PAGE_SIZE"
        case .hp_far_shared: "PF_HP_FAR_SHARED"
        case .hp_near_shared: "PF_HP_NEAR_SHARED"
        case .hp_lazyswap: "PF_HP_LAZYSWAP"
        case .hp_code_depr: "PF_HP_CODE_DEPR"
        case .hp_modify_depr: "PF_HP_MODIFY_DEPR"
        case .hp_lazyswap_depr: "PF_HP_LAZYSWAP_DEPR"
        case .parisc_sbp: "PF_PARISC_SBP"
        case .hp_sbp: "PF_HP_SBP"
        case .ia_64_norecov: "PF_IA_64_NORECOV"
        case .ppc_vle: "PF_PPC_VLE"
        case .overlay: "PF_OVERLAY"
        }
    }
}
