//
//  ELFImage+Dynamics64+.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/08
//  
//

import Foundation
import ELFKitC

// MARK: - Relocations
extension ELFImage.Dynamics64 {
    public func relocations(in elf: ELFImage) -> AnyRandomAccessCollection<ELF64Relocation>? {
        if let _rel, let relcount {
            guard let pointer = _rel.pointer(for: elf) else {
                return nil
            }
            let sequence: MemorySequence<ELF64RelocationInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: ELF64RelocationInfo.self),
                numberOfElements: relcount
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let relacount {
            guard let pointer = _rela.pointer(for: elf) else {
                return nil
            }
            let sequence: MemorySequence<ELF64RelocationAddendInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: ELF64RelocationAddendInfo.self),
                numberOfElements: relacount
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        }
        return nil
    }

    public func pltRelocations(in elf: ELFImage) -> AnyRandomAccessCollection<ELF64Relocation>? {
        guard let _jmprel, let _pltrelsz, let _pltrel else {
            return nil
        }
        guard let pointer = _jmprel.pointer(for: elf) else {
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
            let sequence: MemorySequence<ELF64RelocationInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: ELF64RelocationInfo.self),
                numberOfElements: _pltrelsz.value / entrySize
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )

        case .rela:
            let entrySize = _relaent?.value ?? ELF64RelocationAddendInfo.layoutSize
            guard entrySize > 0 else { return nil }
            let sequence: MemorySequence<ELF64RelocationAddendInfo> = .init(
                basePointer: pointer
                    .assumingMemoryBound(to: ELF64RelocationAddendInfo.self),
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
extension ELFImage.Dynamics64 {
    public func _versionDef(in elf: ELFImage) -> ELF64VersionDef? {
        guard let _verdef else { return nil }
        guard let pointer = _verdef.pointer(for: elf) else {
            return nil
        }
        let layout: ELF64VersionDef.Layout = pointer.autoBoundPointee()
        return .init(
            layout: layout,
            _index: 0,
            _offset: Int(bitPattern: pointer) - Int(bitPattern: elf.ptr)
        )
    }
}

// MARK: - Version Needs
extension ELFImage.Dynamics64 {
    public func _versionNeed(in elf: ELFImage) -> ELF64VersionNeed? {
        guard let _verneed else { return nil }
        guard let pointer = _verneed.pointer(for: elf) else {
            return nil
        }
        let layout: ELF64VersionNeed.Layout = pointer.autoBoundPointee()
        return .init(
            layout: layout,
            _index: 0,
            _offset: Int(bitPattern: pointer) - Int(bitPattern: elf.ptr)
        )
    }
}
