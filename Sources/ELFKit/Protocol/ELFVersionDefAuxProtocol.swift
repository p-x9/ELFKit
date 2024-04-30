//
//  ELFVersionDefAuxProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

public protocol ELFVersionDefAuxProtocol {
    var _offset: Int { get }
    var _index: Int { get }
    var nameOffset: Int { get }
    var nextOffset: Int { get }

    func next(in elf: ELFFile) -> Self?
    func name(in elf: ELFFile) -> String?
}
