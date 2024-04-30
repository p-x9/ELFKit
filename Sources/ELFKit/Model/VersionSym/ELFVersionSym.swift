//
//  ELFVersionSym.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct ELF32VersionSym: LayoutWrapper {
    public typealias Layout = Elf32_Versym

    public var layout: Layout
}

public struct ELF64VersionSym: LayoutWrapper {
    public typealias Layout = Elf64_Versym

    public var layout: Layout
}

extension ELF32VersionSym: ELFVersionSymProtocol {
    public var isHidden: Bool {
        (numericCast(layout) & VERSYM_HIDDEN) != 0
    }

    public var version: Int {
        if isHidden {
            numericCast((numericCast(layout) & VERSYM_VERSION))
        } else {
            numericCast(layout)
        }
    }
}

extension ELF64VersionSym: ELFVersionSymProtocol {
    public var isHidden: Bool {
        (numericCast(layout) & VERSYM_HIDDEN) != 0
    }

    public var version: Int {
        if isHidden {
            numericCast((numericCast(layout) & VERSYM_VERSION))
        } else {
            numericCast(layout)
        }
    }
}
