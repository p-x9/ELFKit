//
//  EFIOSABI.swift
//
//
//  Created by p-x9 on 2024/04/28
//
//

import Foundation

public enum EFIOSABI: CaseIterable {
    /// ELFOSABI_NONE
    case none
    /// ELFOSABI_HPUX
    case hpux
    /// ELFOSABI_NETBSD
    case netbsd
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
    /// ELFOSABI_ARM_AEABI
    case arm_aeabi
    /// ELFOSABI_ARM
    case arm
    /// ELFOSABI_STANDALONE
    case standalone
}

extension EFIOSABI: RawRepresentable {
    public typealias RawValue = UInt8

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(ELFOSABI_NONE): self = .none
        case RawValue(ELFOSABI_HPUX): self = .hpux
        case RawValue(ELFOSABI_NETBSD): self = .netbsd
        case RawValue(ELFOSABI_LINUX): self = .linux
        case RawValue(ELFOSABI_HURD): self = .hurd
        case RawValue(ELFOSABI_86OPEN): self = ._86open
        case RawValue(ELFOSABI_SOLARIS): self = .solaris
        case RawValue(ELFOSABI_AIX): self = .aix
        case RawValue(ELFOSABI_IRIX): self = .irix
        case RawValue(ELFOSABI_FREEBSD): self = .freebsd
        case RawValue(ELFOSABI_TRU64): self = .tru64
        case RawValue(ELFOSABI_MODESTO): self = .modesto
        case RawValue(ELFOSABI_OPENBSD): self = .openbsd
        case RawValue(ELFOSABI_OPENVMS): self = .openvms
        case RawValue(ELFOSABI_NSK): self = .nsk
        case RawValue(ELFOSABI_AROS): self = .aros
        case RawValue(ELFOSABI_FENIXOS): self = .fenixos
        case RawValue(ELFOSABI_CLOUDABI): self = .cloudabi
        case RawValue(ELFOSABI_OPENVOS): self = .openvos
        case RawValue(ELFOSABI_ARM_AEABI): self = .arm_aeabi
        case RawValue(ELFOSABI_ARM): self = .arm
        case RawValue(ELFOSABI_STANDALONE): self = .standalone
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .none: RawValue(ELFOSABI_NONE)
        case .hpux: RawValue(ELFOSABI_HPUX)
        case .netbsd: RawValue(ELFOSABI_NETBSD)
        case .linux: RawValue(ELFOSABI_LINUX)
        case .hurd: RawValue(ELFOSABI_HURD)
        case ._86open: RawValue(ELFOSABI_86OPEN)
        case .solaris: RawValue(ELFOSABI_SOLARIS)
        case .aix: RawValue(ELFOSABI_AIX)
        case .irix: RawValue(ELFOSABI_IRIX)
        case .freebsd: RawValue(ELFOSABI_FREEBSD)
        case .tru64: RawValue(ELFOSABI_TRU64)
        case .modesto: RawValue(ELFOSABI_MODESTO)
        case .openbsd: RawValue(ELFOSABI_OPENBSD)
        case .openvms: RawValue(ELFOSABI_OPENVMS)
        case .nsk: RawValue(ELFOSABI_NSK)
        case .aros: RawValue(ELFOSABI_AROS)
        case .fenixos: RawValue(ELFOSABI_FENIXOS)
        case .cloudabi: RawValue(ELFOSABI_CLOUDABI)
        case .openvos: RawValue(ELFOSABI_OPENVOS)
        case .arm_aeabi: RawValue(ELFOSABI_ARM_AEABI)
        case .arm: RawValue(ELFOSABI_ARM)
        case .standalone: RawValue(ELFOSABI_STANDALONE)
        }
    }
}

extension EFIOSABI: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "ELFOSABI_NONE"
        case .hpux: "ELFOSABI_HPUX"
        case .netbsd: "ELFOSABI_NETBSD"
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
        case .arm_aeabi: "ELFOSABI_ARM_AEABI"
        case .arm: "ELFOSABI_ARM"
        case .standalone: "ELFOSABI_STANDALONE"
        }
    }
}
