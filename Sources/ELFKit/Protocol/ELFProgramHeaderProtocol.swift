//
//  ELFProgramHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//
//

import Foundation

public protocol ELFProgramHeaderProtocol {
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
}

extension ELFProgramHeaderProtocol {
    public func _notes32(in elf: ELFFile) -> ELF32Notes? {
        guard type == .note, !elf.is64Bit else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }

    public func _notes64(in elf: ELFFile) -> ELF64Notes? {
        guard type == .note, elf.is64Bit else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: fileSize
        )
        return .init(data: data)
    }

    public func _notes(in elf: ELFFile) -> [any ELFNoteProtocol]? {
        if elf.is64Bit {
            return _notes64(in: elf)?.map { $0 }
        } else {
            return _notes32(in: elf)?.map { $0 }
        }
    }
}

extension ELFProgramHeaderProtocol {
    public func _dynamic32(in elf: ELFFile) -> ELFFile.Dynamics32? {
        guard type == .dynamic, !elf.is64Bit else { return nil }
        let count = fileSize / ELF32Dynamic.layoutSize
        return .init(
            elf.fileHandle.readDataSequence(
                offset: UInt64(offset),
                numberOfElements: count
            )
        )
    }

    public func _dynamic64(in elf: ELFFile) -> ELFFile.Dynamics64? {
        guard type == .dynamic, elf.is64Bit else { return nil }
        let count = fileSize / ELF64Dynamic.layoutSize
        return .init(
            elf.fileHandle.readDataSequence(
                offset: UInt64(offset),
                numberOfElements: count
            )
        )
    }

    public func _dynamic(in elf: ELFFile) -> [ELFDynamicProtocol]? {
        if elf.is64Bit {
            return _dynamic64(in: elf)?.map { $0 }
        } else {
            return _dynamic32(in: elf)?.map { $0 }
        }
    }
}
