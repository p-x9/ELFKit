//
//  ELFVersionDefProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

public protocol ELFVersionDefProtocol {
    associatedtype Aux: ELFVersionDefAuxProtocol
    
    var _offset: Int { get }
    var _index: Int { get }
    
    var flags: VersionFlags { get }
    var versionIndex: Int { get }
    var numberOfAux: Int { get }
    var hash: Int { get }
    var auxOffset: Int { get }
    var nextOffset: Int { get }

    func next(in elf: ELFFile) -> Self?
    func aux(in elf: ELFFile) -> Aux?
}
