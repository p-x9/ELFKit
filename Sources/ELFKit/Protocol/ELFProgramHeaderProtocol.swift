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
    public func _note32(in elf: ELFFile) -> ELF32Note? {
        guard type == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }

    public func _note64(in elf: ELFFile) -> ELF64Note? {
        guard type == .note else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }

    public func _note(in elf: ELFFile) -> (any ELFNoteProtocol)? {
        if elf.is64Bit {
            return _note64(in: elf)
        } else {
            return _note32(in: elf)
        }
    }
}
