//
//  ELFProgramHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

public protocol ELFProgramHeaderProtocol {
    var type: SegmentType! { get }
    var flags: ProgramFlags { get }
    var offset: Int { get }
    var virtualAddress: Int { get }
    var physicalAddress: Int { get }
    var fileSize: Int { get }
    var memorySize: Int { get }
    var align: Int { get }
}

extension ELFProgramHeaderProtocol {
    public func _notes32(in elf: ELFFile) -> ELFNotes<ELF32Note>? {
        guard type == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }

    public func _notes64(in elf: ELFFile) -> ELFNotes<ELF64Note>? {
        guard type == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }

    public func _notes(in elf: ELFFile) -> [any ELFNoteProtocol]? {
        if elf.is64Bit {
            return _notes64(in: elf)?.map { $0}
        } else {
            return _notes32(in: elf)?.map { $0 }
        }
    }
}
