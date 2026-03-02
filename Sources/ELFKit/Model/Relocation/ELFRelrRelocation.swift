//
//  ELFRelrRelocation.swift
//  ELFKit
//
//  Created by Codex on 2026/03/02.
//
//

import Foundation

/// Expanded relative relocation entry decoded from `DT_RELR` / `SHT_RELR`.
public struct ELFRelrRelocation: Sendable, Hashable {
    public let offset: Int

    public init(offset: Int) {
        self.offset = offset
    }
}

extension ELFRelrRelocation {
    /// Reads the implicit addend stored at the relocation target in the file image.
    public func addend(in elf: ELFFile) -> Int? {
        elf._readPointerValue(atVirtualAddress: offset)
    }
}

extension ELFRelrRelocation {
    /// Reads the currently stored pointer value at the relocation target in memory.
    public func currentValue(in elf: ELFImage) -> Int? {
        elf._readPointerValue(atRelativeOffset: offset)
    }

    /// Derives the implicit addend by subtracting the loaded image base.
    public func addend(in elf: ELFImage) -> Int? {
        guard let currentValue = currentValue(in: elf) else { return nil }
        return currentValue &- Int(bitPattern: elf.ptr)
    }
}

extension ELFFile {
    fileprivate func _readPointerValue(atVirtualAddress virtualAddress: Int) -> Int? {
        guard virtualAddress >= 0 else { return nil }
        guard let offset = fileOffset(of: virtualAddress) else {
            return nil
        }

        if is64Bit {
            guard let value: UInt64 = try? fileHandle.read(offset: offset) else {
                return nil
            }
            return numericCast(value)
        } else {
            guard let value: UInt32 = try? fileHandle.read(offset: offset) else {
                return nil
            }
            return numericCast(value)
        }
    }
}

extension ELFImage {
    fileprivate func _readPointerValue(atRelativeOffset relativeOffset: Int) -> Int? {
        guard relativeOffset >= 0 else { return nil }

        if is64Bit {
            let pointer = ptr
                .advanced(by: relativeOffset)
                .assumingMemoryBound(to: UInt64.self)
            return numericCast(pointer.pointee)
        } else {
            let pointer = ptr
                .advanced(by: relativeOffset)
                .assumingMemoryBound(to: UInt32.self)
            return numericCast(pointer.pointee)
        }
    }
}
