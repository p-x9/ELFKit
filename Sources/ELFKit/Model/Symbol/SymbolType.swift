//
//  SymbolType.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SymbolType: CaseIterable {
    /// STT_NOTYPE
    case notype
    /// STT_OBJECT
    case object
    /// STT_FUNC
    case `func`
    /// STT_SECTION
    case section
    /// STT_FILE
    case file
    /// STT_COMMON
    case common
    /// STT_TLS
    case tls
    /// STT_RELC
    case relc
    /// STT_SRELC
    case srelc
    /// STT_GNU_IFUNC
    case gnu_ifunc
    /// STT_ARM_TFUNC
    case arm_tfunc
    /// STT_ARM_16BIT
    case arm_16bit
    /// STT_PARISC_MILLI
    case parisc_milli
    /// STT_HP_OPAQUE
    case hp_opaque
    /// STT_HP_STUB
    case hp_stub
    /// STT_REGISTER
    case register
    /// STT_RENESAS_ENTRY
    case renesas_entry
}

extension SymbolType/*: RawRepresentable*/ {
    public typealias RawValue = UInt8

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI,
        machine: ELFMachine
    ) {
        switch rawValue {
        case 0: self = .notype
        case 1: self = .object
        case 2: self = .func
        case 3: self = .section
        case 4: self = .file
        case 5: self = .common
        case 6: self = .tls
        case 8: self = .relc
        case 9: self = .srelc

        case 10 where [.linux, .freebsd].contains(osabi):
            self = .gnu_ifunc

        case _ where machine == .arm:
            switch rawValue {
            case 13: self = .arm_tfunc
                return
            case 15: self = .arm_16bit
                return 
            default:
                return nil
            }

        case _ where machine == .parisc:
            switch rawValue {
            case 13: self = .parisc_milli
            case 11: self = .hp_opaque
            case 12: self = .hp_stub
                return
            default:
                return nil
            }

        case _ where machine == .sparcv9:
            switch rawValue {
            case 13: self = .register
                return
            default:
                return nil
            }

        case _ where [.v800, .v850, .cygnus_v850].contains(machine):
            switch rawValue {
            case 14: self = .renesas_entry
                return
            default:
                return nil
            }

        default: return nil
        }
    }
    public var rawValue: RawValue {
        switch self {
        case .notype: 0
        case .object: 1
        case .func: 2
        case .section: 3
        case .file: 4
        case .common: 5
        case .tls: 6
        case .relc: 8
        case .srelc: 9
        case .gnu_ifunc: 10
        case .arm_tfunc: 13
        case .arm_16bit: 15
        case .parisc_milli: 13
        case .hp_opaque: 11
        case .hp_stub: 12
        case .register: 13
        case .renesas_entry: 14
        }
    }
}
extension SymbolType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notype: "STT_NOTYPE"
        case .object: "STT_OBJECT"
        case .func: "STT_FUNC"
        case .section: "STT_SECTION"
        case .file: "STT_FILE"
        case .common: "STT_COMMON"
        case .tls: "STT_TLS"
        case .relc: "STT_RELC"
        case .srelc: "STT_SRELC"
        case .gnu_ifunc: "STT_GNU_IFUNC"
        case .arm_tfunc: "STT_ARM_TFUNC"
        case .arm_16bit: "STT_ARM_16BIT"
        case .parisc_milli: "STT_PARISC_MILLI"
        case .hp_opaque: "STT_HP_OPAQUE"
        case .hp_stub: "STT_HP_STUB"
        case .register: "STT_REGISTER"
        case .renesas_entry: "STT_RENESAS_ENTRY"
        }
    }
}
