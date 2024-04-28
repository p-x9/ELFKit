//
//  ELFGnuHashTableHeader.swift
//
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation

public struct ELFGnuHashTableHeader: LayoutWrapper {
    public typealias Layout = Elf_GNU_Hash_Header
    public var layout: Layout
}
