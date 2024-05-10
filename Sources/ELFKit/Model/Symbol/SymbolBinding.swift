//
//  SymbolBinding.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation
import ELFKitC

public enum SymbolBinding: CaseIterable {
    /// STB_LOCAL
    case local
    /// STB_GLOBAL
    case global
    /// STB_WEAK
    case weak
    /// STB_GNU_UNIQUE
    case gnu_unique
    /// STB_HP_ALIAS
    case hp_alias
    /// STB_VMS_WEAK
    case vms_weak
    /// STB_VMS_SYSTEM
    case vms_system
}

extension SymbolBinding/*: RawRepresentable*/ {
    public typealias RawValue = UInt8

    public init?(
        rawValue: RawValue,
        osabi: ELFOSABI
    ) {
        switch rawValue {
        case 0: self = .local
        case 1: self = .global
        case 2: self = .weak
        case 10 where osabi == .linux: self = .gnu_unique
        case 10 where osabi == .hpux: self = .hp_alias
        case 11 where osabi == .openvms: self = .vms_weak
        case 12 where osabi == .openvms: self = .vms_system
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .local: 0
        case .global: 1
        case .weak: 2
        case .gnu_unique: 10
        case .hp_alias: 10
        case .vms_weak: 11
        case .vms_system: 12
        }
    }
}

extension SymbolBinding: CustomStringConvertible {
    public var description: String {
        switch self {
        case .local: "STB_LOCAL"
        case .global: "STB_GLOBAL"
        case .weak: "STB_WEAK"
        case .gnu_unique: "STB_GNU_UNIQUE"
        case .hp_alias: "STB_HP_ALIAS"
        case .vms_weak: "STB_VMS_WEAK"
        case .vms_system: "STB_VMS_SYSTEM"
        }
    }
}
