//
//  ELFSymbolInfoProtocol.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation

public protocol ELFSymbolInfoProtocol: Sendable {
    var dynamicEntryIndex: Int? { get }
    var specialBound: SymbolInfoSpecialBound? { get }
    var flags: SymbolInfoFlags { get }
}
