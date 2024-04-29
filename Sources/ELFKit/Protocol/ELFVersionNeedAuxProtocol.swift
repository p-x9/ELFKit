//
//  ELFVersionDefNeedProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

public protocol ELFVersionNeedAuxProtocol {
    var _offset: Int { get }
    var _index: Int { get }
    var nextOffset: Int { get }
    var hash: Int { get }
    var version: Int { get }

    func next(in elf: ELFFile) -> Self?
    func name(in elf: ELFFile) -> String?
}
