//
//  ELFProgramHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation

public protocol ELFProgramHeaderProtocol {
    associatedtype Relocation: ELFRelocationProtocol
    associatedtype Note: ELFNoteProtocol
    associatedtype Dynamics: ELFFileDynamicsSequence

    var _commonType: ProgramType? { get }
    func type(inELF header: ELFHeader) -> ProgramType?

    var _commonFlags: ProgramFlags { get }
    func flags(inELF header: ELFHeader) -> ProgramFlags

    var offset: Int { get }
    var virtualAddress: Int { get }
    var physicalAddress: Int { get }
    var fileSize: Int { get }
    var memorySize: Int { get }
    var align: Int { get }

    func _notes(in elf: ELFFile) -> _ELFNotes<Note>?
    func _dynamics(in elf: ELFFile) -> Dynamics?
}

extension ELFProgramHeaderProtocol {
    public func _notes(in elf: ELFFile) -> _ELFNotes<Note>? {
        guard type(inELF: elf.header) == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
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

extension ELFProgramHeaderProtocol {
    public func _dynamics(in elf: ELFFile) -> Dynamics? {
        guard type(inELF: elf.header) == .dynamic else { return nil }
        let count = fileSize / Dynamics.Dynamic.layoutSize
        return .init(
            elf.fileHandle.readDataSequence(
                offset: UInt64(offset),
                numberOfElements: count
            )
        )
    }
}
