//
//  Sections.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

extension Sequence where Element: ELFSectionHeaderProtocol {
    var _dynamic: Element? {
        first(where: { $0.type == .dynamic })
    }

    var _dynsym: Element? {
        first(where: { $0.type == .dynsym })
    }

    var _symtab: Element? {
        first(where: { $0.type == .symtab })
    }

    func _dynstr(in elf: ELFFile) -> Element? {
        first(where: { $0.name(in: elf) == ".dynstr" })
    }

    func _strtab(in elf: ELFFile) -> Element? {
        first(where: { $0.name(in: elf) == ".strtab" })
    }
}
