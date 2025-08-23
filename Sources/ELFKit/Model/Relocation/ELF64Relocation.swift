//
//  ELF64Relocation.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public enum ELF64Relocation: Sendable {
    case general(ELF64RelocationInfo)
    case addend(ELF64RelocationAddendInfo)
}

extension ELF64Relocation: ELFRelocationProtocol {
    public var offset: Int {
        switch self {
        case let .general(v): numericCast(v.r_offset)
        case let .addend(v): numericCast(v.r_offset)
        }
    }

    public var symbolIndex: Int {
        switch self {
        case let .general(v): v.symbolIndex
        case let .addend(v): v.symbolIndex
        }
    }

    public var _type: Int {
        switch self {
        case let .general(v): numericCast(v._type)
        case let .addend(v): numericCast(v._type)
        }
    }

    public var addend: Int {
        switch self {
        case let .addend(v): numericCast(v.r_addend)
        default: 0
        }
    }
}
