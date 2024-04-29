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

    func next(in elf: ELFFile) -> Self?
    func fileName(in elf: ELFFile) -> String?
    func aux(in elf: ELFFile) -> Aux?
}
