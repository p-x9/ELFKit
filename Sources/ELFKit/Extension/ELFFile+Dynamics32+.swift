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
            let sequence: DataSequence<ELF32RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rel.pointer),
                numberOfElements: relcount
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let relacount {
            let sequence: DataSequence<ELF32RelocationAddendInfo> = elf.fileHandle.readDataSequence(
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
extension ELFFile.Dynamics32 {
    public func _versionDef(in elf: ELFFile) -> ELF32VersionDef? {
        guard let _verdef else { return nil }
        let layout: ELF32VersionDef.Layout = elf.fileHandle.read(
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
extension ELFFile.Dynamics32 {
    public func _versionNeed(in elf: ELFFile) -> ELF32VersionNeed? {
        guard let _verneed else { return nil }
        let layout: ELF32VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(_verneed.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verneed.pointer)
        )
    }

    public func versionNeeds(in elf: ELFFile) -> [ELF32VersionNeed] {
        var def = _versionNeed(in: elf)
        var defs: [ELF32VersionNeed] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }
}
