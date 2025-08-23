//
//  ELFVersionNeedAux.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct ELF32VersionNeedAux: LayoutWrapper, Sendable {
    public typealias Layout = Elf32_Vernaux

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

public struct ELF64VersionNeedAux: LayoutWrapper, Sendable {
    public typealias Layout = Elf64_Vernaux

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

extension ELF32VersionNeedAux: ELFVersionNeedAuxProtocol {
    public var hash: Int {
        numericCast(layout.vna_hash)
    }

    public var flags: VersionFlags {
        .init(rawValue: layout.vna_flags)
    }

    public var version: Int {
        numericCast(layout.vna_other)
    }

    public var nextOffset: Int {
        numericCast(layout.vna_next)
    }
}

extension ELF32VersionNeedAux {
    public func name(in elf: ELFFile) -> String? {
        guard let dynamics = elf.dynamics32,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: numericCast(layout.vna_name))?.string
    }

    public func _next(in elf: ELFFile) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        let offset = self._offset + nextOffset
        let layout: Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: _index + 1,
            _offset: offset
        )
    }
}

extension ELF32VersionNeedAux {
    public func name(in elf: ELFImage) -> String? {
        guard let dynamics = elf.dynamics32,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: numericCast(layout.vna_name))?.string
    }

    public func _next(in elf: ELFImage) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        let offset = self._offset + nextOffset
        let layout: Layout = elf.ptr
            .advanced(by: offset)
            .autoBoundPointee()
        return .init(
            layout: layout,
            _index: _index + 1,
            _offset: offset
        )
    }
}

extension ELF64VersionNeedAux: ELFVersionNeedAuxProtocol {
    public var hash: Int {
        numericCast(layout.vna_hash)
    }

    public var flags: VersionFlags {
        .init(rawValue: layout.vna_flags)
    }

    public var version: Int {
        numericCast(layout.vna_other)
    }

    public var nextOffset: Int {
        numericCast(layout.vna_next)
    }
}

extension ELF64VersionNeedAux {
    public func name(in elf: ELFFile) -> String? {
        guard let dynamics = elf.dynamics64,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: numericCast(layout.vna_name))?.string
    }

    public func _next(in elf: ELFFile) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        let offset = self._offset + nextOffset
        let layout: Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: _index + 1,
            _offset: offset
        )
    }
}

extension ELF64VersionNeedAux {
    public func name(in elf: ELFImage) -> String? {
        guard let dynamics = elf.dynamics64,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: numericCast(layout.vna_name))?.string
    }

    public func _next(in elf: ELFImage) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        let offset = self._offset + nextOffset
        let layout: Layout = elf.ptr
            .advanced(by: offset)
            .autoBoundPointee()
        return .init(
            layout: layout,
            _index: _index + 1,
            _offset: offset
        )
    }
}
