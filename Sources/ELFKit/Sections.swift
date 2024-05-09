//
//  Sections.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

extension Sequence where Element: ELFSectionHeaderProtocol {
    func _dynamic(in elf: ELFFile) -> Element? {
        first(where: { $0.type(inELF: elf.header) == .dynamic })
    }

    func _dynsym(in elf: ELFFile) -> Element? {
        first(where: { $0.type(inELF: elf.header) == .dynsym })
    }

    func _symtab(in elf: ELFFile) -> Element? {
        first(where: { $0.type(inELF: elf.header) == .symtab })
    }

    func _dynstr(in elf: ELFFile) -> Element? {
        first(where: { $0.name(in: elf) == ".dynstr" })
    }

    func _strtab(in elf: ELFFile) -> Element? {
        first(where: { $0.name(in: elf) == ".strtab" })
    }
}
