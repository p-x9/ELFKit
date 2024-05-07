//
//  ELFFile+Dynamics32+.swift
//
//
//  Created by p-x9 on 2024/05/02
//  
//

import Foundation
import ELFKitC

// MARK: - Relocations
extension ELFFile.Dynamics32 {
    public func relocations(in elf: ELFFile) -> AnyRandomAccessCollection<ELF32Relocation>? {
        if let _rel, let relcount {
            guard let offset = elf.fileOffset(of: _rel.pointer) else {
                return nil
            }
            let sequence: DataSequence<ELF32RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: relcount
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let relacount {
            guard let offset = elf.fileOffset(of: _rela.pointer) else {
                return nil
            }
            let sequence: DataSequence<ELF32RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: relacount
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        }
        return nil
    }
}

// MARK: - Version Defs
extension ELFFile.Dynamics32 {
    public func _versionDef(in elf: ELFFile) -> ELF32VersionDef? {
        guard let _verdef else { return nil }
        guard let offset = elf.fileOffset(of: _verdef.pointer) else {
            return nil
        }
        let layout: ELF32VersionDef.Layout = elf.fileHandle.read(
            offset: numericCast(offset)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(offset)
        )
    }
}

// MARK: - Version Needs
extension ELFFile.Dynamics32 {
    public func _versionNeed(in elf: ELFFile) -> ELF32VersionNeed? {
        guard let _verneed else { return nil }
        guard let offset = elf.fileOffset(of: _verneed.pointer) else {
            return nil
        }
        let layout: ELF32VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(offset)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(offset)
        )
    }
}
