//
//  ELFDynamic+.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

extension Sequence where Element: ELFDynamicProtocol {
    var _neededs: [Element] { filter { $0._commonTag == .needed } }
    var _soname: Element? { first(where: { $0._commonTag == .soname }) }

    var _strtab: Element? { first(where: { $0._commonTag == .strtab }) }
    var _strsiz: Element? { first(where: { $0._commonTag == .strsz }) }

    var _hash: Element? { first(where: { $0._commonTag == .hash }) }
    func _gnu_hash(inELF header: ELFHeader) -> Element? {
        first(where: { $0.tag(inELF: header) == .gnu_hash })
    }

    var _symtab: Element? { first(where: { $0._commonTag == .symtab }) }
    var _syment: Element? { first(where: { $0._commonTag == .syment }) }

    var _rela: Element? { first(where: { $0._commonTag == .rela }) }
    var _relasz: Element? { first(where: { $0._commonTag == .relasz }) }
    var _relacount: Element? { first(where: { $0._commonTag == .relacount }) }
    var _relaent: Element? { first(where: { $0._commonTag == .relaent }) }
    var _rel: Element? { first(where: { $0._commonTag == .rel }) }
    var _relsz: Element? { first(where: { $0._commonTag == .relsz }) }
    var _relcount: Element? { first(where: { $0._commonTag == .relcount }) }
    var _relent: Element? { first(where: { $0._commonTag == .relent }) }

    var _rpath: [Element] { filter { $0._commonTag == .rpath } }
    var _runpath: [Element] { filter { $0._commonTag == .runpath } }

    var _flags: Element? { first(where: { $0._commonTag == .flags }) }
    var _flags_1: Element? { first(where: { $0._commonTag == .flags_1 }) }

    var _syminfo: Element? { first(where: { $0._commonTag == .syminfo }) }
    var _syminsz: Element? { first(where: { $0._commonTag == .syminsz }) }

    var _verdef: Element? { first(where: { $0._commonTag == .verdef }) }
    var _verdefnum: Element? { first(where: { $0._commonTag == .verdefnum }) }

    var _verneed: Element? { first(where: { $0._commonTag == .verneed }) }
    var _verneednum: Element? { first(where: { $0._commonTag == .verneednum }) }

    var _versym: Element? { first(where: { $0._commonTag == .versym }) }
}
