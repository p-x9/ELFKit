//
//  ELFVersionNeedProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

public protocol ELFVersionNeedProtocol {
    associatedtype Aux: ELFVersionNeedAuxProtocol

    var _offset: Int { get }
    var _index: Int { get }

    var fileNameOffset: Int { get }
    var numberOfAux: Int { get }
    var auxOffset: Int { get }
    var nextOffset: Int { get }

    func fileName(in elf: ELFFile) -> String?
    func auxes(in elf: ELFFile) -> [Aux]
    func _next(in elf: ELFFile) -> Self?
    func _aux(in elf: ELFFile) -> Aux?

    func fileName(in elf: ELFImage) -> String?
    func auxes(in elf: ELFImage) -> [Aux]
    func _next(in elf: ELFImage) -> Self?
    func _aux(in elf: ELFImage) -> Aux?
}

extension ELFVersionNeedProtocol {
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
