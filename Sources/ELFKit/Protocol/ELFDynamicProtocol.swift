//
//  ELFDynamicProtocol.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

public protocol ELFDynamicProtocol {
    var tag: DynamicTag? { get }
    var osSpecificTag: DynamicTag.OSSpecific { get }
    var processorSpecificTag: DynamicTag.ProcessorSpecific { get }
    var value: Int { get }
    var pointer: Int { get }
}
