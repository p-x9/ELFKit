//
//  ELF64Dynamic.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public struct ELF64Dynamic: LayoutWrapper {
    public typealias Layout = Elf64_Dyn

    public var layout: Layout
}

extension ELF64Dynamic: ELFDynamicProtocol {
    public var tag: DynamicTag! {
        .init(rawValue: numericCast(layout.d_tag))
    }
}