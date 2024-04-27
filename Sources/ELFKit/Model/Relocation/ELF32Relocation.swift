//
//  ELF32Relocation.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public enum ELF32Relocation {
    case general(ELF32RelocationInfo)
    case addend(ELF32RelocationAddendInfo)
}

extension ELF32Relocation {
    public var offset: UInt32 {
        switch self {
        case let .general(v): v.r_offset
        case let .addend(v): v.r_offset
        }
    }

    public var symbolIndex: Int {
        switch self {
        case let .general(v): v.symbolIndex
        case let .addend(v): v.symbolIndex
        }
    }

    public var type: UInt32 {
        switch self {
        case let .general(v): v.type
        case let .addend(v): v.type
        }
    }

    public var addend: Int32 {
        switch self {
        case let .addend(v): v.r_addend
        default: 0
        }
    }
}
