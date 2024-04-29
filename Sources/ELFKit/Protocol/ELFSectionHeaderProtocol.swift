//
//  ELFSectionHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

public protocol ELFSectionHeaderProtocol {
    var nameOffset: Int { get }
    var type: SectionType! { get }
    var flags: SectionFlags { get }
    var address: Int { get }
    var offset: Int { get }
    var size: Int { get }
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

extension ELFSectionHeaderProtocol {
    public func _relocations32(in elf: ELFFile) -> AnyRandomAccessCollection<ELF32Relocation>? {
        guard !elf.is64Bit else { return nil }
        switch type {
        case .rel:
            let count = size / ELF32RelocationInfo.layoutSize
            let sequence: DataSequence<ELF32RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence
                    .map {
                        .general($0)
                    }
            )
        case .rela:
            let count = size / ELF32RelocationAddendInfo.layoutSize
            let sequence: DataSequence<ELF32RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence
                    .map {
                        .addend($0)
                    }
            )
        default:
            return nil
        }
    }

    public func _relocations64(in elf: ELFFile) -> AnyRandomAccessCollection<ELF64Relocation>? {
        guard elf.is64Bit else { return nil }
        switch type {
        case .rel:
            let count = size / ELF64RelocationInfo.layoutSize
            let sequence: DataSequence<ELF64RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        case .rela:
            let count = size / ELF64RelocationAddendInfo.layoutSize
            let sequence: DataSequence<ELF64RelocationAddendInfo> = elf.fileHandle.readDataSequence(
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

    public func _relocations(in elf: ELFFile) -> [any ELFRelocationProtocol]? {
        if elf.is64Bit {
            return _relocations64(in: elf)?.map { $0 }
        } else {
            return _relocations32(in: elf)?.map { $0 }
        }
    }
}

extension ELFSectionHeaderProtocol {
    public func _note32(in elf: ELFFile) -> ELF32Note? {
        guard type == .note, !elf.is64Bit else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: size
        )
        return .init(data: data)
    }

    public func _note64(in elf: ELFFile) -> ELF64Note? {
        guard type == .note, elf.is64Bit else { return nil }
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: size
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

extension ELFSectionHeaderProtocol {
    public func _dynamic32(in elf: ELFFile) -> DataSequence<ELF32Dynamic>? {
        guard type == .dynamic, !elf.is64Bit else { return nil }
        let count = size / ELF32Dynamic.layoutSize
        return elf.fileHandle.readDataSequence(
            offset: UInt64(offset),
            numberOfElements: count
        )
    }

    public func _dynamic64(in elf: ELFFile) -> DataSequence<ELF64Dynamic>? {
        guard type == .dynamic, elf.is64Bit else { return nil }
        let count = size / ELF64Dynamic.layoutSize
        return elf.fileHandle.readDataSequence(
            offset: UInt64(offset),
            numberOfElements: count
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
