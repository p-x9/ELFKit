//
//  ELF32RelocationInfo.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public struct ELF32RelocationInfo: LayoutWrapper {
    public typealias Layout = Elf32_Rel

    public var layout: Layout
}

public struct ELF32RelocationAddendInfo: LayoutWrapper {
    public typealias Layout = Elf32_Rela

    public var layout: Layout
}

extension ELF32RelocationInfo {
    public var symbolIndex: Int {
        numericCast(layout.r_info >> 8) // ELF32_R_SYM
    }

    public var _type: UInt32 {
        layout.r_info & 0xff// ELF32_R_TYPE
    }
}

extension ELF32RelocationAddendInfo {
    public var symbolIndex: Int {
        numericCast(layout.r_info >> 8) // ELF32_R_SYM
    }

    public var _type: UInt32 {
        layout.r_info & 0xff// ELF32_R_TYPE
    }
}
