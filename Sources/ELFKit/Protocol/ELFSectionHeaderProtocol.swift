//
//  ELFSectionHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation

public protocol ELFSectionHeaderProtocol: Sendable {
    associatedtype Relocation: ELFRelocationProtocol
    associatedtype Note: ELFNoteProtocol
    associatedtype Dynamic: ELFDynamicProtocol

    var nameOffset: Int { get }

    var _commonFlags: SectionFlags { get }
    func flags(inELF header: ELFHeader) -> SectionFlags

    var address: Int { get }
    var offset: Int { get }
    var size: Int { get }
    var link: Int { get }
    var addressAlignment: Int { get }
    var entrySize: Int { get }

    var _commonType: SectionType? { get }
    func type(inELF header: ELFHeader) -> SectionType?

    func name(in elf: ELFFile) -> String?

    func _strings(in elf: ELFFile) -> ELFFile.Strings?
    func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>?
    func _notes(in elf: ELFFile) -> _ELFNotes<Note>?
    func _dynamics(in elf: ELFFile) -> DataSequence<Dynamic>?

    func _hashTableHeader(in elf: ELFFile) -> Dynamic.HashTableHeader?
    func _hashTable(in elf: ELFFile) -> Dynamic.HashTable?

    func _gnuHashTableHeader(in elf: ELFFile) -> ELFGnuHashTableHeader?
    func _gnuHashTable(in elf: ELFFile) -> Dynamic.GnuHashTable?

    func _versionDef(in elf: ELFFile) -> Dynamic.VersionDef?
    func _versionDefs(in elf: ELFFile) -> [Dynamic.VersionDef]?

    func _versionNeed(in elf: ELFFile) -> Dynamic.VersionNeed?
    func _versionNeeds(in elf: ELFFile) -> [Dynamic.VersionNeed]?

    func _versionSyms(in elf: ELFFile) -> DataSequence<Dynamic.VersionSym>?

    func _strings(in elf: ELFImage) -> ELFImage.Strings?
}

extension ELFSectionHeaderProtocol {
    public func name(in elf: ELFFile) -> String? {
        guard let data = elf.sectionHeaderStrings?.data else {
            return nil
        }
        return String(
            cString: data.advanced(by: nameOffset)
        )
    }
}

// MARK: - String Table
extension ELFSectionHeaderProtocol {
    public func _strings(in elf: ELFFile) -> ELFFile.Strings? {
        guard type(inELF: elf.header) == .strtab else { return nil }
        return .init(
            elf: elf,
            offset: offset,
            size: size,
            isSwapped: false
        )
    }

    public func _strings(in elf: ELFImage) -> ELFImage.Strings? {
        guard type(inELF: elf.header) == .strtab else { return nil }
        return .init(
            basePointer: elf.ptr
                .advanced(by: offset)
                .assumingMemoryBound(to: UInt8.self),
            offset: offset,
            tableSize: size
        )
    }
}

// MARK: - Note
extension ELFSectionHeaderProtocol {
    public func _notes(in elf: ELFFile) -> _ELFNotes<Note>? {
        guard type(inELF: elf.header) == .note else { return nil }
        let data = try! elf.fileHandle.readData(
            offset: offset,
            length: size
        )
        return .init(data: data)
    }

    @_disfavoredOverload
    public func _notes(in elf: ELFFile) -> AnySequence<any ELFNoteProtocol>? {
        guard let sequence: _ELFNotes<Note> = _notes(in: elf) else {
            return nil
        }
        return AnySequence(sequence.map {
            $0 as (any ELFNoteProtocol)
        })
    }
}

// MARK: - Dynamics
extension ELFSectionHeaderProtocol where Dynamic: LayoutWrapper {
    public func _dynamics(in elf: ELFFile) -> DataSequence<Dynamic>? {
        guard type(inELF: elf.header) == .dynamic else { return nil }
        let count = size / Dynamic.layoutSize
        return .init(
            elf.fileHandle.readDataSequence(
                offset: UInt64(offset),
                numberOfElements: count
            )
        )
    }
}

extension ELFSectionHeaderProtocol where Relocation: ELFRelocationLayoutConvertible {
    public func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>? {
        switch type(inELF: elf.header) {
        case .rel:
            let count = size / Relocation.RelInfo.layoutSize
            let sequence: DataSequence<Relocation.RelInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        case .rela:
            let count = size / Relocation.RelaInfo.layoutSize
            let sequence: DataSequence<Relocation.RelaInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        default:
            return nil
        }
    }
}

// MARK: - Hash Table
extension ELFSectionHeaderProtocol where Dynamic.HashTableHeader: LayoutWrapper {
    public func _hashTableHeader(in elf: ELFFile) -> Dynamic.HashTableHeader? {
        guard type(inELF: elf.header) == .hash else { return nil }
        return try! elf.fileHandle.read(
            offset: offset
        )
    }

    public func _hashTable(in elf: ELFFile) -> Dynamic.HashTable? {
        guard let header = _hashTableHeader(in: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: offset
        )
    }
}

// MARK: - GNU Hash Table
extension ELFSectionHeaderProtocol {
    public func _gnuHashTableHeader(in elf: ELFFile) -> ELFGnuHashTableHeader? {
        guard let name = name(in: elf),
              name.starts(with: ".gnu"),
              type(inELF: elf.header) == .gnu_hash else {
            return nil
        }
        return try! elf.fileHandle.read(
            offset: offset
        )
    }

    public func _gnuHashTable(in elf: ELFFile) -> Dynamic.GnuHashTable? {
        guard let header = _gnuHashTableHeader(in: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: offset
        )
    }
}

// MARK: - Verson Defs
extension ELFSectionHeaderProtocol {
    public func _versionDefs(in elf: ELFFile) -> [Dynamic.VersionDef]? {
        var def = _versionDef(in: elf)
        if def == nil { return nil }
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
extension ELFSectionHeaderProtocol {
    public func _versionNeeds(in elf: ELFFile) -> [Dynamic.VersionNeed]? {
        var def = _versionNeed(in: elf)
        if def == nil { return nil }
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
extension ELFSectionHeaderProtocol where Dynamic.VersionSym: LayoutWrapper {
    public func _versionSyms(in elf: ELFFile) -> DataSequence<Dynamic.VersionSym>? {
        guard [.gnu_versym, .sunw_versym].contains(type(inELF: elf.header)) else {
            return nil
        }
        let numberOfSymbols = size / Dynamic.VersionSym.layoutSize
        return elf.fileHandle.readDataSequence(
            offset: numericCast(offset),
            numberOfElements: numberOfSymbols
        )
    }
}
