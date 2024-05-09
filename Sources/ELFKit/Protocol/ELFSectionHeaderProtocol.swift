//
//  ELFSectionHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation

public protocol ELFSectionHeaderProtocol {
    associatedtype Relocation: ELFRelocationProtocol
    associatedtype Note: ELFNoteProtocol
    associatedtype Dynamics: ELFFileDynamicsSequence

    var nameOffset: Int { get }
    var flags: SectionFlags { get }
    var address: Int { get }
    var offset: Int { get }
    var size: Int { get }
    var link: Int { get }
    var addressAlignment: Int { get }
    var entrySize: Int { get }

    func type(inELF header: ELFHeader) -> SectionType?

    func name(in elf: ELFFile) -> String?

    func _strings(in elf: ELFFile) -> ELFFile.Strings?
    func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>?
    func _notes(in elf: ELFFile) ->  _ELFNotes<Note>?
    func _dynamics(in elf: ELFFile) -> Dynamics?

    func _hashTableHeader(in elf: ELFFile) -> Dynamics.HashTableHeader?
    func _hashTable(in elf: ELFFile) -> Dynamics.HashTable?

    func _gnuHashTableHeader(in elf: ELFFile) -> ELFGnuHashTableHeader?
    func _gnuHashTable(in elf: ELFFile) -> Dynamics.GnuHashTable?

    func _versionDef(in elf: ELFFile) -> Dynamics.VersionDef?
    func _versionDefs(in elf: ELFFile) -> [Dynamics.VersionDef]?

    func _versionNeed(in elf: ELFFile) -> Dynamics.VersionNeed?
    func _versionNeeds(in elf: ELFFile) -> [Dynamics.VersionNeed]?

    func _versionSyms(in elf: ELFFile) -> DataSequence<Dynamics.VersionSym>?
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
            size: size
        )
    }
}

// MARK: - Note
extension ELFSectionHeaderProtocol {
    public func _notes(in elf: ELFFile) ->  _ELFNotes<Note>? {
        guard type(inELF: elf.header) == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: size
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
extension ELFSectionHeaderProtocol {
    public func _dynamics(in elf: ELFFile) -> Dynamics? {
        guard type(inELF: elf.header) == .dynamic else { return nil }
        let count = size / Dynamics.Dynamic.layoutSize
        return .init(
            elf.fileHandle.readDataSequence(
                offset: UInt64(offset),
                numberOfElements: count
            )
        )
    }
}

// MARK: - Hash Table
extension ELFSectionHeaderProtocol {
    public func _hashTableHeader(in elf: ELFFile) -> Dynamics.HashTableHeader? {
        guard type(inELF: elf.header) == .hash else { return nil }
        return elf.fileHandle.read(
            offset: numericCast(offset)
        )
    }

    public func _hashTable(in elf: ELFFile) -> Dynamics.HashTable? {
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
        return elf.fileHandle.read(
            offset: numericCast(offset)
        )
    }

    public func _gnuHashTable(in elf: ELFFile) -> Dynamics.GnuHashTable? {
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
    public func _versionDefs(in elf: ELFFile) -> [Dynamics.VersionDef]? {
        var def = _versionDef(in: elf)
        if def == nil { return nil }
        var defs: [Dynamics.VersionDef] = []
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
    public func _versionNeeds(in elf: ELFFile) -> [Dynamics.VersionNeed]? {
        var def = _versionNeed(in: elf)
        if def == nil { return nil }
        var defs: [Dynamics.VersionNeed] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }
}

// MARK: - Version Syms
extension ELFSectionHeaderProtocol {
    public func _versionSyms(in elf: ELFFile) -> DataSequence<Dynamics.VersionSym>? {
        guard [.gnu_versym, .sunw_versym].contains(type(inELF: elf.header)) else {
            return nil
        }
        let numberOfSymbols = size / Dynamics.VersionSym.layoutSize
        return elf.fileHandle.readDataSequence(
            offset: numericCast(offset),
            numberOfElements: numberOfSymbols
        )
    }
}
