//
//  ELFOSABI.swift
//
//
//  Created by p-x9 on 2024/04/28
//
//

import Foundation

public enum ELFOSABI: CaseIterable {
    /// ELFOSABI_NONE
    case none
    /// ELFOSABI_HPUX
    case hpux
    /// ELFOSABI_NETBSD
    case netbsd
//    /// ELFOSABI_GNU
//    case gnu
    /// ELFOSABI_LINUX
    case linux
    /// ELFOSABI_HURD
    case hurd
    /// ELFOSABI_86OPEN
    case _86open
    /// ELFOSABI_SOLARIS
    case solaris
    /// ELFOSABI_AIX
    case aix
    /// ELFOSABI_IRIX
    case irix
    /// ELFOSABI_FREEBSD
    case freebsd
    /// ELFOSABI_TRU64
    case tru64
    /// ELFOSABI_MODESTO
    case modesto
    /// ELFOSABI_OPENBSD
    case openbsd
    /// ELFOSABI_OPENVMS
    case openvms
    /// ELFOSABI_NSK
    case nsk
    /// ELFOSABI_AROS
    case aros
    /// ELFOSABI_FENIXOS
    case fenixos
    /// ELFOSABI_CLOUDABI
    case cloudabi
    /// ELFOSABI_OPENVOS
    case openvos
    /// ELFOSABI_C6000_ELFABI
    case c6000_elfabi
    /// ELFOSABI_AMDGPU_HSA
    case amdgpu_hsa
    /// ELFOSABI_C6000_LINUX
    case c6000_linux
    /// ELFOSABI_AMDGPU_PAL
    case amdgpu_pal
    /// ELFOSABI_ARM_FDPIC
    case arm_fdpic
    /// ELFOSABI_AMDGPU_MESA3D
    case amdgpu_mesa3d
    /// ELFOSABI_ARM
    case arm
    /// ELFOSABI_STANDALONE
    case standalone
}

extension ELFOSABI/*: RawRepresentable*/ {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue, machine: ELFMachine) {
        switch rawValue {
        case 0: self = .none
        case 1: self = .hpux
        case 2: self = .netbsd
//        case 3: self = .gnu
        case 3: self = .linux
        case 4: self = .hurd
        case 5: self = ._86open
        case 6: self = .solaris
        case 7: self = .aix
        case 8: self = .irix
        case 9: self = .freebsd
        case 10: self = .tru64
        case 11: self = .modesto
        case 12: self = .openbsd
        case 13: self = .openvms
        case 14: self = .nsk
        case 15: self = .aros
        case 16: self = .fenixos
        case 17: self = .cloudabi
        case 18: self = .openvos
        case _ where machine == .amdgpu:
            switch rawValue {
            case 64: self = .amdgpu_hsa
            case 65: self = .amdgpu_pal
            case 66: self = .amdgpu_mesa3d
            default: return nil
            }
        case _ where machine == .arm:
            switch rawValue {
            case 65: self = .arm_fdpic
            case 97: self = .arm
            default: return nil
            }
        case _ where [.msp430, .visium].contains(machine):
            switch rawValue {
            case 0xff: self = .standalone
            default: return nil
            }
        case _ where machine == .ti_c6000:
            switch rawValue {
            case 64: self = .c6000_elfabi
            case 65: self = .c6000_linux
            default: return nil
            }
        default: return nil
        }
    }
    public var rawValue: RawValue {
        switch self {
        case .none: 0
        case .hpux: 1
        case .netbsd: 2
//        case .gnu: 3
        case .linux: 3
        case .hurd: 4
        case ._86open: 5
        case .solaris: 6
        case .aix: 7
        case .irix: 8
        case .freebsd: 9
        case .tru64: 10
        case .modesto: 11
        case .openbsd: 12
        case .openvms: 13
        case .nsk: 14
        case .aros: 15
        case .fenixos: 16
        case .cloudabi: 17
        case .openvos: 18
        case .c6000_elfabi: 64
        case .amdgpu_hsa: 64
        case .c6000_linux: 65
        case .amdgpu_pal: 65
        case .arm_fdpic: 65
        case .amdgpu_mesa3d: 66
        case .arm: 97
        case .standalone: 0xff
        }
    }
}
extension ELFOSABI: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ELFOSABI_NONE"
        case .hpux: "ELFOSABI_HPUX"
        case .netbsd: "ELFOSABI_NETBSD"
//        case .gnu: "ELFOSABI_GNU"
        case .linux: "ELFOSABI_LINUX"
        case .hurd: "ELFOSABI_HURD"
        case ._86open: "ELFOSABI_86OPEN"
        case .solaris: "ELFOSABI_SOLARIS"
        case .aix: "ELFOSABI_AIX"
        case .irix: "ELFOSABI_IRIX"
        case .freebsd: "ELFOSABI_FREEBSD"
        case .tru64: "ELFOSABI_TRU64"
        case .modesto: "ELFOSABI_MODESTO"
        case .openbsd: "ELFOSABI_OPENBSD"
        case .openvms: "ELFOSABI_OPENVMS"
        case .nsk: "ELFOSABI_NSK"
        case .aros: "ELFOSABI_AROS"
        case .fenixos: "ELFOSABI_FENIXOS"
        case .cloudabi: "ELFOSABI_CLOUDABI"
        case .openvos: "ELFOSABI_OPENVOS"
        case .c6000_elfabi: "ELFOSABI_C6000_ELFABI"
        case .amdgpu_hsa: "ELFOSABI_AMDGPU_HSA"
        case .c6000_linux: "ELFOSABI_C6000_LINUX"
        case .amdgpu_pal: "ELFOSABI_AMDGPU_PAL"
        case .arm_fdpic: "ELFOSABI_ARM_FDPIC"
        case .amdgpu_mesa3d: "ELFOSABI_AMDGPU_MESA3D"
        case .arm: "ELFOSABI_ARM"
        case .standalone: "ELFOSABI_STANDALONE"
        }
    }
}
