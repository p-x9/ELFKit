//
//  ELFDynamicProtocol.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

public protocol ELFDynamicProtocol {
    associatedtype HashTable: ELFHashTableProtocol
    associatedtype GnuHashTable: ELFGnuHashTableProtocol
    associatedtype Symbol: ELFSymbolProtocol
    associatedtype Relocation: ELFRelocationProtocol
    associatedtype SymbolInfo: ELFSymbolInfoProtocol
    associatedtype VersionDef: ELFVersionDefProtocol
    associatedtype VersionNeed: ELFVersionNeedProtocol
    associatedtype VersionSym: ELFVersionSymProtocol

    typealias HashTableHeader = HashTable.Header

    var _commonTag: DynamicTag? { get }
    func tag(inELF header: ELFHeader) -> DynamicTag?

    var value: Int { get }
    var pointer: Int { get }
}

extension ELFDynamicProtocol {
    public func pointer(for elf: ELFImage) -> UnsafeRawPointer? {
        if Int(bitPattern: elf.ptr) > pointer {
            return elf.ptr.advanced(by: pointer)
        }
        return UnsafeRawPointer(bitPattern: pointer)
    }
}
