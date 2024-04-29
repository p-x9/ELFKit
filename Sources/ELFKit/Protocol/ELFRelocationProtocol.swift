//
//  ELFRelocationProtocol.swift
//
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation

public protocol ELFRelocationProtocol {
    var offset: Int { get }
    var symbolIndex: Int { get }
    var _type: Int { get }
    var addend: Int { get }
}
