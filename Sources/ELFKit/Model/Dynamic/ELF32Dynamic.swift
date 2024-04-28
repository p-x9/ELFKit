//
//  ELF32Dynamic.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public struct ELF32Dynamic: LayoutWrapper {
    public typealias Layout = Elf32_Dyn

    public var layout: Layout
}

extension ELF32Dynamic: ELFDynamicProtocol {
    public var tag: DynamicTag! {
        .init(rawValue: numericCast(layout.d_tag))
    }

    public var value: Int {
        numericCast(layout.d_un.d_val)
    }
    
    public var pointer: Int {
        numericCast(layout.d_un.d_ptr)
    }
}
