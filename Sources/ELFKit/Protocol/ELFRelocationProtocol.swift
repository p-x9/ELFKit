//
//  ELFRelocationProtocol.swift
//
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation

public protocol ELFRelocationProtocol: Sendable {
    var offset: Int { get }
    var symbolIndex: Int { get }
    var _type: Int { get }
    var addend: Int { get }
}

public protocol ELFRelocationLayoutConvertible: ELFRelocationProtocol {
    associatedtype RelInfo: LayoutWrapper
    associatedtype RelaInfo: LayoutWrapper

    static func general(_ info: RelInfo) -> Self
    static func addend(_ info: RelaInfo) -> Self
}
