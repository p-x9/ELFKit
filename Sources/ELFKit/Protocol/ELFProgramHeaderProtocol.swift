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

    var type: ProgramType! { get }
    var osSpecificType: ProgramType.OSSpecific { get }
    var processorSpecificType: ProgramType.ProcessorSpecific { get }
    var flags: ProgramFlags { get }
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
        guard type == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }
}

extension ELFProgramHeaderProtocol {
    public func _dynamics(in elf: ELFFile) -> Dynamics? {
        guard type == .dynamic else { return nil }
        let count = fileSize / Dynamics.Dynamic.layoutSize
        return .init(
            elf.fileHandle.readDataSequence(
                offset: UInt64(offset),
                numberOfElements: count
            )
        )
    }
}
