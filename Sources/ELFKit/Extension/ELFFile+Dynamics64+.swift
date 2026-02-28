//
//  ELFFile+Dynamics64+.swift
//
//
//  Created by p-x9 on 2024/05/02
//  
//

import Foundation
import ELFKitC

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
