//
//  ELFDynamicProtocol.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

public protocol ELFDynamicProtocol {
    var _commonTag: DynamicTag? { get }
    func tag(inELF header: ELFHeader) -> DynamicTag?

    var value: Int { get }
    var pointer: Int { get }
}
