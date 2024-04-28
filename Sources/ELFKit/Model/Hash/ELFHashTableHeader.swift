//
//  ELFHashTableHeader.swift
//  
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation
import ELFKitC

public struct ELF32HashTableHeader: LayoutWrapper {
    public struct Layout {
        public let nbuckets: Elf32_Hashelt
        public let nchain: Elf32_Hashelt
    }
    public var layout: Layout
}

public struct ELF64HashTableHeader: LayoutWrapper {
    public struct Layout {
        public let nbuckets: Elf64_Hashelt
        public let nchain: Elf64_Hashelt
    }
    public var layout: Layout
}

extension ELF32HashTableHeader: ELFHashTableHeaderProtocol {
    public var numberOfBuckets: Int {
        numericCast(layout.nbuckets)
    }
    
    public var numberOfChains: Int {
        numericCast(layout.nchain)
    }
}

extension ELF64HashTableHeader: ELFHashTableHeaderProtocol {
    public var numberOfBuckets: Int {
        numericCast(layout.nbuckets)
    }

    public var numberOfChains: Int {
        numericCast(layout.nchain)
    }
}
