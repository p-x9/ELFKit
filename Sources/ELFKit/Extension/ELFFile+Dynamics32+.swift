//
//  ELFFile+Dynamics32+.swift
//
//
//  Created by p-x9 on 2024/05/02
//  
//

import Foundation
import ELFKitC

// MARK: - Version Defs
extension ELFFile.Dynamics32 {
    public func _versionDef(in elf: ELFFile) -> ELF32VersionDef? {
        guard let _verdef else { return nil }
        guard let offset = elf.fileOffset(of: _verdef.pointer) else {
            return nil
        }
        let layout: ELF32VersionDef.Layout = try! elf.fileHandle.read(
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
extension ELFFile.Dynamics32 {
    public func _versionNeed(in elf: ELFFile) -> ELF32VersionNeed? {
        guard let _verneed else { return nil }
        guard let offset = elf.fileOffset(of: _verneed.pointer) else {
            return nil
        }
        let layout: ELF32VersionNeed.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(offset)
        )
    }
}
