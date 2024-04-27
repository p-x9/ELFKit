//
//  Sections.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

extension Sequence where Element: ELFSectionHeaderProtocol {
    var _symtab: Element? {
        first(where: { $0.type == .symtab })
    }

    func _strtab(in elf: ELFFile) -> Element? {
        first(where: { $0.name(in: elf) == ".strtab" })
    }
}

extension ELFFile {
    var _symtab: (any ELFSectionHeaderProtocol)? {
        if is64Bit { sections64?._symtab }
        else { sections32?._symtab }
    }

    var _strtab: (any ELFSectionHeaderProtocol)? {
        if is64Bit { sections64?._strtab(in: self) }
        else { sections32?._strtab(in: self) }
    }
}
