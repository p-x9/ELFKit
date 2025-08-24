//
//  ELF64RelocationInfo.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public struct ELF64RelocationInfo: LayoutWrapper, Sendable {
    public typealias Layout = Elf64_Rel

    public var layout: Layout
}

public struct ELF64RelocationAddendInfo: LayoutWrapper, Sendable {
    public typealias Layout = Elf64_Rela

    public var layout: Layout
}

extension ELF64RelocationInfo {
    public var symbolIndex: Int {
        numericCast(layout.r_info >> 32) // ELF64_R_SYM
    }

    public var _type: UInt64 {
        layout.r_info & 0xffffffff// ELF64_R_TYPE
    }
}

extension ELF64RelocationAddendInfo {
    public var symbolIndex: Int {
        numericCast(layout.r_info >> 32) // ELF64_R_SYM
    }

    public var _type: UInt64 {
        layout.r_info & 0xffffffff// ELF64_R_TYPE
    }
}
