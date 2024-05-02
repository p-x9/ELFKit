//
//  ELFFile+Dynamics64+.swift
//
//
//  Created by p-x9 on 2024/05/02
//  
//

import Foundation
import ELFKitC

// MARK: - Relocations
extension ELFFile.Dynamics64 {
    public func relocations(in elf: ELFFile) -> AnyRandomAccessCollection<ELF64Relocation>? {
        if let _rel, let relcount {
            let sequence: DataSequence<ELF64RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rel.pointer),
                numberOfElements: relcount
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let relacount {
            let sequence: DataSequence<ELF64RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rela.pointer),
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
extension ELFFile.Dynamics64 {
    public func _versionDef(in elf: ELFFile) -> ELF64VersionDef? {
        guard let _verdef else { return nil }
        let layout: ELF64VersionDef.Layout = elf.fileHandle.read(
            offset: numericCast(_verdef.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verdef.pointer)
        )
    }
}

// MARK: - Version Needs
extension ELFFile.Dynamics64 {
    public func _versionNeed(in elf: ELFFile) -> ELF64VersionNeed? {
        guard let _verneed else { return nil }
        let layout: ELF64VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(_verneed.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verneed.pointer)
        )
    }
}
