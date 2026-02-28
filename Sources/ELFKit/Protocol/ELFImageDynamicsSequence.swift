//
//  ELFImageDynamicsSequence.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

public protocol ELFImageDynamicsSequence<Dynamic>: ELFDynamicsSequence
where Iterator == WrappedSequence.Iterator {
    typealias WrappedSequence = MemorySequence<Dynamic>

    var sequence: WrappedSequence { get }

    init(_ sequence: WrappedSequence)

    func strings(in elf: ELFImage) -> ELFImage.Strings?
    func neededs(in elf: ELFImage) -> [String]
    func rpaths(in elf: ELFImage) -> [String]
    func runpaths(in elf: ELFImage) -> [String]
    func sharedObjectName(in elf: ELFImage) -> String?

    func hashTableHeader(in elf: ELFImage) -> Dynamic.HashTableHeader?
    func hashTable(in elf: ELFImage) -> Dynamic.HashTable?

    func gnuHashTableHeader(in elf: ELFImage) -> ELFGnuHashTableHeader?
    func gnuHashTable(in elf: ELFImage) -> Dynamic.GnuHashTable?

    func numberOfSymbols(in elf: ELFImage) -> Int?
    func symbols(in elf: ELFImage) -> MemorySequence<Dynamic.Symbol>?

    func symbolInfos(in elf: ELFImage) -> MemorySequence<Dynamic.SymbolInfo>?

    func relocations(in elf: ELFImage) -> AnyRandomAccessCollection<Dynamic.Relocation>?
    func pltRelocations(in elf: ELFImage) -> AnyRandomAccessCollection<Dynamic.Relocation>?

    var flags: DynamicFlags { get }
    var flags1: DynamicFlags1 { get }

    var numberOfVersionDefs: Int? { get }
    func _versionDef(in elf: ELFImage) -> Dynamic.VersionDef?
    func versionDefs(in elf: ELFImage) -> [Dynamic.VersionDef]

    var numberOfVersionNeeds: Int? { get }
    func _versionNeed(in elf: ELFImage) -> Dynamic.VersionNeed?
    func versionNeeds(in elf: ELFImage) -> [Dynamic.VersionNeed]

    func versionSyms(in elf: ELFImage) -> MemorySequence<Dynamic.VersionSym>?
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
        guard let pointer = _strtab.pointer(for: elf) else {
            return nil
        }
        let size = _strsiz.value
        return .init(
            basePointer: pointer
                .assumingMemoryBound(to: UInt8.self),
            offset: Int(bitPattern: pointer) - Int(bitPattern: elf.ptr),
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

// MARK: Hash Table
extension ELFImageDynamicsSequence where Dynamic.HashTableHeader: LayoutWrapper {
    public func hashTableHeader(in elf: ELFImage) -> Dynamic.HashTableHeader? {
        guard let _hash else { return nil }
        guard let pointer = _hash.pointer(for: elf) else {
            return nil
        }
        return pointer.autoBoundPointee()
    }

    public func hashTable(in elf: ELFImage) -> Dynamic.HashTable? {
        guard let _hash else { return nil }
        guard let header = hashTableHeader(in: elf) else {
            return nil
        }
        guard let pointer = _hash.pointer(for: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: Int(bitPattern: pointer) - Int(bitPattern: elf.ptr)
        )
    }
}

// MARK: - GNU Hash Table
extension ELFImageDynamicsSequence {
    public func gnuHashTableHeader(in elf: ELFImage) -> ELFGnuHashTableHeader? {
        guard let gnu_hash = _gnu_hash(inELF: elf.header) else { return nil }
        guard let pointer = gnu_hash.pointer(for: elf) else {
            return nil
        }
        return pointer.autoBoundPointee()
    }

    public func gnuHashTable(in elf: ELFImage) -> Dynamic.GnuHashTable? {
        guard let gnu_hash = _gnu_hash(inELF: elf.header) else { return nil }
        guard let header = gnuHashTableHeader(in: elf) else {
            return nil
        }
        guard let pointer = gnu_hash.pointer(for: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: Int(bitPattern: pointer) - Int(bitPattern: elf.ptr)
        )
    }
}

// MARK: - Symbols(Dynamic)
extension ELFImageDynamicsSequence {
    public func numberOfSymbols(in elf: ELFImage) -> Int? {
        if let hashHeader = hashTableHeader(in: elf) {
            return hashHeader.numberOfChains
        } else if let gnuHashTable = gnuHashTable(in: elf) {
            return gnuHashTable.numberOfSymbols(in: elf)
        }
        return nil
    }

    public func symbols(in elf: ELFImage) -> MemorySequence<Dynamic.Symbol>? {
        guard let _symtab else { return nil }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        guard let pointer = _symtab.pointer(for: elf) else {
            return nil
        }
        return .init(
            basePointer: pointer
                .assumingMemoryBound(to: Dynamic.Symbol.self),
            numberOfElements: numberOfSymbols
        )
    }
}

// MARK: - Relocations
extension ELFImageDynamicsSequence {
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

extension ELFImageDynamicsSequence where Dynamic.Relocation: ELFRelocationLayoutConvertible {
    public func relocations(in elf: ELFImage) -> AnyRandomAccessCollection<Dynamic.Relocation>? {
        if let _rel, let relcount {
            guard let pointer = _rel.pointer(for: elf) else {
                return nil
            }
            let sequence: MemorySequence<Dynamic.Relocation.RelInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: Dynamic.Relocation.RelInfo.self),
                numberOfElements: relcount
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let relacount {
            guard let pointer = _rela.pointer(for: elf) else {
                return nil
            }
            let sequence: MemorySequence<Dynamic.Relocation.RelaInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: Dynamic.Relocation.RelaInfo.self),
                numberOfElements: relacount
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        }
        return nil
    }

    public func pltRelocations(in elf: ELFImage) -> AnyRandomAccessCollection<Dynamic.Relocation>? {
        guard let _jmprel, let _pltrelsz, let _pltrel else {
            return nil
        }
        guard let pointer = _jmprel.pointer(for: elf) else {
            return nil
        }
        guard let pltrelType = DynamicTag(
            rawValue: numericCast(_pltrel.value),
            osabi: .none,
            machine: .none
        ) else {
            return nil
        }

        switch pltrelType {
        case .rel:
            let entrySize = _relent?.value ?? Dynamic.Relocation.RelInfo.layoutSize
            guard entrySize > 0 else { return nil }
            let sequence: MemorySequence<Dynamic.Relocation.RelInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: Dynamic.Relocation.RelInfo.self),
                numberOfElements: _pltrelsz.value / entrySize
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )

        case .rela:
            let entrySize = _relaent?.value ?? Dynamic.Relocation.RelaInfo.layoutSize
            guard entrySize > 0 else { return nil }
            let sequence: MemorySequence<Dynamic.Relocation.RelaInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: Dynamic.Relocation.RelaInfo.self),
                numberOfElements: _pltrelsz.value / entrySize
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )

        default:
            return nil
        }
    }
}

// MARK: - SymbolInfos
extension ELFImageDynamicsSequence where Dynamic.SymbolInfo: LayoutWrapper {
    public func symbolInfos(in elf: ELFImage) -> MemorySequence<Dynamic.SymbolInfo>? {
        guard let _syminfo, let _syminsz else { return nil }
        guard let pointer = _syminfo.pointer(for: elf) else {
            return nil
        }
        return .init(
            basePointer: pointer
                .assumingMemoryBound(to: Dynamic.SymbolInfo.self),
            numberOfElements: numericCast(_syminsz.value) / Dynamic.SymbolInfo.layoutSize
        )
    }
}

// MARK: - FLAGS / FLAGS_1
extension ELFImageDynamicsSequence {
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
extension ELFImageDynamicsSequence {
    public var numberOfVersionDefs: Int? {
        guard let _verdefnum else { return nil }
        return numericCast(_verdefnum.value)
    }

    public func versionDefs(in elf: ELFImage) -> [Dynamic.VersionDef] {
        var def = _versionDef(in: elf)
        var defs: [Dynamic.VersionDef] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }
}

// MARK: - Verson Needs
extension ELFImageDynamicsSequence {
    public var numberOfVersionNeeds: Int? {
        guard let _verneednum else { return nil }
        return numericCast(_verneednum.value)
    }

    public func versionNeeds(in elf: ELFImage) -> [Dynamic.VersionNeed] {
        var def = _versionNeed(in: elf)
        var defs: [Dynamic.VersionNeed] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }
}

// MARK: - Version Syms
extension ELFImageDynamicsSequence {
    public func versionSyms(in elf: ELFImage) -> MemorySequence<Dynamic.VersionSym>? {
        guard let _versym else { return nil }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        guard let pointer = _versym.pointer(for: elf) else {
            return nil
        }
        return .init(
            basePointer: pointer
                .assumingMemoryBound(to: Dynamic.VersionSym.self),
            numberOfElements: numberOfSymbols
        )
    }
}
