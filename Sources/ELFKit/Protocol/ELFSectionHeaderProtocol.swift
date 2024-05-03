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

    var osSpecificType: SectionType.OSSpecific { get }
    var processorSpecificType: SectionType.ProcessorSpecific { get }

    func name(in elf: ELFFile) -> String?

    func _strings(in elf: ELFFile) -> ELFFile.Strings?
    func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>?
    func _note(in elf: ELFFile) -> Note?
    func _dynamic(in elf: ELFFile) -> Dynamics?
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
    public func _dynamic(in elf: ELFFile) -> Dynamics? {
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
