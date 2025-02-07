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
    var hash: Int { get }
    var flags: VersionFlags { get }
    var version: Int { get }
    var nextOffset: Int { get }

    func name(in elf: ELFFile) -> String?
    func _next(in elf: ELFFile) -> Self?

    func name(in elf: ELFImage) -> String?
    func _next(in elf: ELFImage) -> Self?
}
