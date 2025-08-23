//
//  ELFVersionDefProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

public protocol ELFVersionDefProtocol: Sendable {
    associatedtype Aux: ELFVersionDefAuxProtocol

    var _offset: Int { get }
    var _index: Int { get }

    var flags: VersionFlags { get }
    var versionIndex: Int { get }
    var numberOfAux: Int { get }
    var hash: Int { get }
    var auxOffset: Int { get }
    var nextOffset: Int { get }

    func auxes(in elf: ELFFile) -> [Aux]
    func _next(in elf: ELFFile) -> Self?
    func _aux(in elf: ELFFile) -> Aux?

    func auxes(in elf: ELFImage) -> [Aux]
    func _next(in elf: ELFImage) -> Self?
    func _aux(in elf: ELFImage) -> Aux?
}

extension ELFVersionDefProtocol {
    public func auxes(in elf: ELFFile) -> [Aux] {
        var aux = _aux(in: elf)
        var auxes: [Aux] = []
        while aux != nil {
            guard let _aux = aux else { break }
            auxes.append(_aux)
            aux = _aux._next(in: elf)
        }
        return auxes
    }

    public func auxes(in elf: ELFImage) -> [Aux] {
        var aux = _aux(in: elf)
        var auxes: [Aux] = []
        while aux != nil {
            guard let _aux = aux else { break }
            auxes.append(_aux)
            aux = _aux._next(in: elf)
        }
        return auxes
    }
}
