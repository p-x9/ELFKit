//
//  ELFFileDynamicsSequence.swift
//
//
//  Created by p-x9 on 2024/05/03
//  
//

import Foundation

public protocol ELFFileDynamicsSequence<Dynamic>: RandomAccessCollection
where Element == Dynamic,
      Iterator == WrappedSequence.Iterator,
      Index == Int,
      HashTable.Header == HashTableHeader
{
    associatedtype Dynamic: ELFDynamicProtocol & LayoutWrapper
    associatedtype HashTableHeader: ELFHashTableHeaderProtocol & LayoutWrapper
    associatedtype HashTable: ELFHashTableProtocol
    associatedtype GnuHashTable: ELFGnuHashTableProtocol
    associatedtype Symbol: ELFSymbolProtocol
    associatedtype Relocation: ELFRelocationProtocol
    associatedtype SymbolInfo: ELFSymbolInfoProtocol
    associatedtype VersionDef: ELFVersionDefProtocol
    associatedtype VersionNeed: ELFVersionNeedProtocol
    associatedtype VersionSym: ELFVersionSymProtocol & LayoutWrapper

    typealias WrappedSequence = DataSequence<Dynamic>

    var sequence: WrappedSequence { get }

    init(_ sequence: WrappedSequence)

    func hashTableHeader(in elf: ELFFile) -> HashTableHeader?
    func hashTable(in elf: ELFFile) -> HashTable?

    func gnuHashTable(in elf: ELFFile) -> GnuHashTable?

    func numberOfSymbols(in elf: ELFFile) -> Int?
    func symbols(in elf: ELFFile) -> DataSequence<Symbol>?

    func relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>?

    func symbolInfos(in elf: ELFFile) -> DataSequence<SymbolInfo>?

    func _versionDef(in elf: ELFFile) -> VersionDef?
    func versionDefs(in elf: ELFFile) -> [VersionDef]

    func _versionNeed(in elf: ELFFile) -> VersionNeed?
    func versionNeeds(in elf: ELFFile) -> [VersionNeed]

    func versionSyms(in elf: ELFFile) -> DataSequence<VersionSym>?
}

extension ELFFileDynamicsSequence {
    public func makeIterator() -> Iterator {
        sequence.makeIterator()
    }
}

extension ELFFileDynamicsSequence {
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
extension ELFFileDynamicsSequence {
    // same as `.dynstr` section
    public func strings(in elf: ELFFile) -> ELFFile.Strings? {
        guard let _strtab, let _strsiz else {
            return nil
        }
        let offset = _strtab.pointer
        let size = _strsiz.value
        return .init(elf: elf, offset: offset, size: size)
    }
}

// MARK: - Needs
extension ELFFileDynamicsSequence {
    public func neededs(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _neededs.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}

// MARK: - Run Paths
extension ELFFileDynamicsSequence {
    public func rpaths(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _rpath.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }

    public func runpaths(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _runpath.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}

// MARK: - SO Name
extension ELFFileDynamicsSequence {
    public func sharedObjectName(in elf: ELFFile) -> String? {
        guard let _soname else { return nil }
        guard let strings = strings(in: elf) else { return nil }
        return strings.string(at: _soname.value)?.string
    }
}

// MARK: Hash Table
extension ELFFileDynamicsSequence {
    public func hashTableHeader(in elf: ELFFile) -> HashTableHeader? {
        guard let _hash else { return nil }
        return elf.fileHandle.read(
            offset: numericCast(_hash.pointer)
        )
    }

    public func hashTable(in elf: ELFFile) -> HashTable? {
        guard let _hash else { return nil }
        guard let header = hashTableHeader(in: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: numericCast(_hash.pointer)
        )
    }
}

// MARK: - GNU Hash Table
extension ELFFileDynamicsSequence {
    public func gnuHashTableHeader(in elf: ELFFile) -> ELFGnuHashTableHeader? {
        guard let _gnu_hash else { return nil }
        return elf.fileHandle.read(
            offset: numericCast(_gnu_hash.pointer)
        )
    }

    public func gnuHashTable(in elf: ELFFile) -> GnuHashTable? {
        guard let _gnu_hash else { return nil }
        guard let header = gnuHashTableHeader(in: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: numericCast(_gnu_hash.pointer)
        )
    }
}

// MARK: - Symbols(Dynamic)
extension ELFFileDynamicsSequence {
    public func numberOfSymbols(in elf: ELFFile) -> Int? {
        if let hashHeader = hashTableHeader(in: elf) {
            return hashHeader.numberOfChains
        } else if let gnuHashTable = gnuHashTable(in: elf) {
            return gnuHashTable.numberOfSymbols(in: elf)
        }
        return nil
    }

    public func symbols(in elf: ELFFile) -> DataSequence<Symbol>? {
        guard let _symtab else { return nil }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_symtab.pointer),
            numberOfElements: numberOfSymbols
        )
    }
}

// MARK: - Relocations
extension ELFFileDynamicsSequence {
    internal var relcount: Int? {
        if let _relsz, let _relent {
            return numericCast(_relsz.value / _relent.value)
        }
        if let _relcount {
            return numericCast(_relcount.value)
        }
        return nil
    }

    internal var relacount: Int? {
        if let _relasz, let _relaent {
            return numericCast(_relasz.value / _relaent.value)
        }
        if let _relacount {
            return numericCast(_relacount.value)
        }
        return nil
    }
}

// MARK: - SymbolInfos
extension ELFFileDynamicsSequence where SymbolInfo: LayoutWrapper {
    public func symbolInfos(in elf: ELFFile) -> DataSequence<SymbolInfo>? {
        guard let _syminfo, let _syminsz else { return nil }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_syminfo.pointer),
            numberOfElements: numericCast(_syminsz.value) / SymbolInfo.layoutSize
        )
    }
}

// MARK: - FLAGS / FLAGS_1
extension ELFFileDynamicsSequence {
    public var flags: DynamicFlags {
        guard let _flags else {
            return .init(rawValue: 0)
        }
        return .init(rawValue: numericCast(_flags.value))
    }

    public var flags1: DynamicFlags1 {
        guard let _flags_1 else {
            return .init(rawValue: 0)
        }
        return .init(rawValue: numericCast(_flags_1.value))
    }
}

// MARK: - Verson Defs
extension ELFFileDynamicsSequence {
    public var numberOfVersionDefs: Int? {
        guard let _verdefnum else { return nil }
        return numericCast(_verdefnum.value)
    }

    public func versionDefs(in elf: ELFFile) -> [VersionDef] {
        var def = _versionDef(in: elf)
        var defs: [VersionDef] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }
}

// MARK: - Verson Needs
extension ELFFileDynamicsSequence {
    public var numberOfVersionNeeds: Int? {
        guard let _verneednum else { return nil }
        return numericCast(_verneednum.value)
    }

    public func versionNeeds(in elf: ELFFile) -> [VersionNeed] {
        var def = _versionNeed(in: elf)
        var defs: [VersionNeed] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }
}

// MARK: - Version Syms
extension ELFFileDynamicsSequence {
    public func versionSyms(in elf: ELFFile) -> DataSequence<VersionSym>? {
        guard let _versym else { return nil }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_versym.pointer),
            numberOfElements: numberOfSymbols
        )
    }
}
