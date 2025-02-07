//
//  ELFImageDynamicsSequence.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

public protocol ELFImageDynamicsSequence<Dynamic>: RandomAccessCollection
where Element == Dynamic,
      Iterator == WrappedSequence.Iterator,
      Index == Int,
      HashTable.Header == HashTableHeader {
    associatedtype Dynamic: ELFDynamicProtocol, LayoutWrapper
    associatedtype HashTableHeader: ELFHashTableHeaderProtocol, LayoutWrapper
    associatedtype HashTable: ELFHashTableProtocol
    associatedtype GnuHashTable: ELFGnuHashTableProtocol
    associatedtype Symbol: ELFSymbolProtocol
    associatedtype Relocation: ELFRelocationProtocol
    associatedtype SymbolInfo: ELFSymbolInfoProtocol
    associatedtype VersionDef: ELFVersionDefProtocol
    associatedtype VersionNeed: ELFVersionNeedProtocol
    associatedtype VersionSym: ELFVersionSymProtocol, LayoutWrapper

    typealias WrappedSequence = MemorySequence<Dynamic>

    var sequence: WrappedSequence { get }

    init(_ sequence: WrappedSequence)
}

extension ELFImageDynamicsSequence {
    public func makeIterator() -> Iterator {
        sequence.makeIterator()
    }
}

extension ELFImageDynamicsSequence {
    public var startIndex: Index { sequence.startIndex }
    public var endIndex: Index { sequence.endIndex }

    public func index(after i: Int) -> Int {
        sequence.index(after: i)
    }

    public subscript(position: Int) -> Element {
        sequence[position]
    }
}

// MARK: - String Table
extension ELFImageDynamicsSequence {
    // same as `.dynstr` section
    public func strings(in elf: ELFImage) -> ELFImage.Strings? {
        guard let _strtab, let _strsiz else {
            return nil
        }
        guard let pointer = UnsafeRawPointer(bitPattern: _strtab.pointer) else {
            return nil
        }
        let size = _strsiz.value
        return .init(
            basePointer: pointer
                .assumingMemoryBound(to: UInt8.self),
            tableSize: size
        )
    }
}

// MARK: - Needs
extension ELFImageDynamicsSequence {
    public func neededs(in elf: ELFImage) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _neededs.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}

// MARK: - Run Paths
extension ELFImageDynamicsSequence {
    public func rpaths(in elf: ELFImage) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _rpath.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }

    public func runpaths(in elf: ELFImage) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _runpath.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}

// MARK: - SO Name
extension ELFImageDynamicsSequence {
    public func sharedObjectName(in elf: ELFImage) -> String? {
        guard let _soname else { return nil }
        guard let strings = strings(in: elf) else { return nil }
        return strings.string(at: _soname.value)?.string
    }
}
