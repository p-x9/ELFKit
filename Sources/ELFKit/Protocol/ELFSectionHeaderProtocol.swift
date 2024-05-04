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
    var type: SectionType? { get }
    var flags: SectionFlags { get }
    var address: Int { get }
    var offset: Int { get }
    var size: Int { get }
    var link: Int { get }
    var addressAlignment: Int { get }
    var entrySize: Int { get }

    var osSpecificType: SectionType.OSSpecific { get }
    var processorSpecificType: SectionType.ProcessorSpecific { get }

    func name(in elf: ELFFile) -> String?

    func _strings(in elf: ELFFile) -> ELFFile.Strings?
    func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>?
    func _note(in elf: ELFFile) -> Note?
    func _dynamics(in elf: ELFFile) -> Dynamics?
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
        guard type == .strtab else { return nil }
        return .init(
            elf: elf,
            offset: offset,
            size: size
        )
    }
}

// MARK: - Note
extension ELFSectionHeaderProtocol {
    public func _note(in elf: ELFFile) -> Note? {
        guard type == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: size
        )
        return .init(data: data)
    }
}

// MARK: - Dynamics
extension ELFSectionHeaderProtocol {
    public func _dynamics(in elf: ELFFile) -> Dynamics? {
        guard type == .dynamic else { return nil }
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
        guard type == .hash else { return nil }
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
              osSpecificType.gnu == .hash else {
            return nil
        }
        return elf.fileHandle.read(
            offset: numericCast(offset)
        )
    }

    public func gnuHashTable(in elf: ELFFile) -> Dynamics.GnuHashTable? {
        guard let header = _gnuHashTableHeader(in: elf) else {
            return nil
        }
        return header._readContent(
            in: elf,
            at: offset
        )
    }
}
