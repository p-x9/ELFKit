//
//  ELF32Header.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct ELF32Header: LayoutWrapper {
    public typealias Layout = Elf32_Ehdr
    public var layout: Layout
}

extension ELF32Header {
    public var identifier: HeaderIdentifier! {
        .init(layout: layout.e_ident)
    }

    public var type: ELFType! {
        .init(rawValue: layout.e_type)
    }

    public var machine: ELFMachine! {
        .init(rawValue: numericCast(layout.e_machine))
    }

    public var osABI: EFIOSABI! {
        .init(
            rawValue: identifier.layout.7,  // EI_OSABI
            machine: machine
        )
    }
}
