//
//  ELFDynamic+.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

extension Sequence where Element: ELFDynamicProtocol {
    var _neededs: [Element] { filter { $0.tag == .needed } }

    var _strtab: Element? { first(where: { $0.tag == .strtab }) }
    var _strsiz: Element? { first(where: { $0.tag == .strsz }) }

    var _hash: Element? { first(where: { $0.tag == .hash }) }
    var _gnu_hash: Element? { first(where: { $0.tag == .gnu_hash }) }
    var _symtab: Element? { first(where: { $0.tag == .symtab }) }
    var _syment: Element? { first(where: { $0.tag == .syment }) }

    var _rela: Element? { first(where: { $0.tag == .rela }) }
    var _relasz: Element? { first(where: { $0.tag == .relasz }) }
    var _rel: Element? { first(where: { $0.tag == .rel }) }
    var _relsz: Element? { first(where: { $0.tag == .relsz }) }

    var _rpath: [Element] { filter { $0.tag == .rpath } }
    var _runpath: [Element] { filter { $0.tag == .runpath } }
}

extension Sequence where Element: ELFDynamicProtocol {
    // same as `.dynstr` section
    public func strings(in elf: ELFFile) -> ELFFile.Strings? {
        guard let _strtab, let _strsiz else {
            return nil
        }
        let offset = _strtab.pointer
        let size = _strsiz.value
        return .init(elf: elf, offset: offset, size: size)
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func neededs(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _neededs.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}
