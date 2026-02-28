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
            guard let offset = elf.fileOffset(of: _rel.pointer) else {
                return nil
            }
            let sequence: DataSequence<ELF64RelocationInfo> = elf.fileHandle.readDataSequence(
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
            let sequence: DataSequence<ELF64RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: relacount
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        }
        return nil
    }

    public func pltRelocations(in elf: ELFFile) -> AnyRandomAccessCollection<ELF64Relocation>? {
        guard let _jmprel, let _pltrelsz, let _pltrel else {
            return nil
        }
        guard let offset = elf.fileOffset(of: _jmprel.pointer) else {
            return nil
        }
        guard let pltrelType = DynamicTag(
            rawValue: numericCast(_pltrel.value),
            osabi: .none,
            machine: .none
        ) else {
            return nil
        }

        switch pltrelType {
        case .rel:
            let entrySize = _relent?.value ?? ELF64RelocationInfo.layoutSize
            guard entrySize > 0 else { return nil }
            let sequence: DataSequence<ELF64RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: _pltrelsz.value / entrySize
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )

        case .rela:
            let entrySize = _relaent?.value ?? ELF64RelocationAddendInfo.layoutSize
            guard entrySize > 0 else { return nil }
            let sequence: DataSequence<ELF64RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: _pltrelsz.value / entrySize
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )

        default:
            return nil
        }
    }
}

// MARK: - Version Defs
extension ELFFile.Dynamics64 {
    public func _versionDef(in elf: ELFFile) -> ELF64VersionDef? {
        guard let _verdef else { return nil }
        guard let offset = elf.fileOffset(of: _verdef.pointer) else {
            return nil
        }
        let layout: ELF64VersionDef.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(offset)
        )
    }
}

// MARK: - Version Needs
extension ELFFile.Dynamics64 {
    public func _versionNeed(in elf: ELFFile) -> ELF64VersionNeed? {
        guard let _verneed else { return nil }
        guard let offset = elf.fileOffset(of: _verneed.pointer) else {
            return nil
        }
        let layout: ELF64VersionNeed.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(offset)
        )
    }
}
