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
    var _soname: Element? { first(where: { $0.tag == .soname }) }

    var _strtab: Element? { first(where: { $0.tag == .strtab }) }
    var _strsiz: Element? { first(where: { $0.tag == .strsz }) }

    var _hash: Element? { first(where: { $0.tag == .hash }) }
    var _gnu_hash: Element? { first(where: { $0.tag == .gnu_hash }) }
    var _symtab: Element? { first(where: { $0.tag == .symtab }) }
    var _syment: Element? { first(where: { $0.tag == .syment }) }

    var _rela: Element? { first(where: { $0.tag == .rela }) }
    var _relasz: Element? { first(where: { $0.tag == .relasz }) }
    var _relacount: Element? { first(where: { $0.tag == .relacount }) }
    var _relaent: Element? { first(where: { $0.tag == .relaent }) }
    var _rel: Element? { first(where: { $0.tag == .rel }) }
    var _relsz: Element? { first(where: { $0.tag == .relsz }) }
    var _relcount: Element? { first(where: { $0.tag == .relcount }) }
    var _relent: Element? { first(where: { $0.tag == .relent }) }

    var _rpath: [Element] { filter { $0.tag == .rpath } }
    var _runpath: [Element] { filter { $0.tag == .runpath } }

    var _flags: Element? { first(where: { $0.tag == .flags }) }
    var _flags_1: Element? { first(where: { $0.tag == .flags_1 }) }

    var _syminfo: Element? { first(where: { $0.tag == .syminfo }) }
    var _syminsz: Element? { first(where: { $0.tag == .syminsz }) }

    var _verdef: Element? { first(where: { $0.tag == .verdef }) }
    var _verdefnum: Element? { first(where: { $0.tag == .verdefnum }) }

    var _verneed: Element? { first(where: { $0.tag == .verneed }) }
    var _verneednum: Element? { first(where: { $0.tag == .verneednum }) }

    var _versym: Element? { first(where: { $0.tag == .versym }) }
}
