//
//  ELF64Header.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct ELF64Header: LayoutWrapper {
    public var layout: Elf64_Ehdr
}

extension ELF64Header {
    public var identifier: HeaderIdentifier! {
        .init(layout: layout.e_ident)
    }

    public var type: ELFType {
        .init(rawValue: layout.e_type)!
    }

    public var machine: ELFMachine! {
        .init(rawValue: numericCast(layout.e_machine))
    }
}
