//
//  ELFImage+Dynamics64+.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/08
//  
//

import Foundation
import ELFKitC

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
