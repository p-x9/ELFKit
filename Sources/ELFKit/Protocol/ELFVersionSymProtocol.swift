//
//  ELFVersionSymProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

// ref: https://github.com/freebsd/freebsd-src/blob/f76effed14b25bfa0c47b10f6d8a076104c48d94/contrib/elftoolchain/readelf/readelf.c#L4113
public protocol ELFVersionSymProtocol: Sendable {
    var isHidden: Bool { get }
    var version: Int { get }
}
