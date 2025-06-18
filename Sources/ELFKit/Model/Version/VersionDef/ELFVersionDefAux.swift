//
//  ELFVersionDefAux.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct ELF32VersionDefAux: LayoutWrapper {
    public typealias Layout = Elf32_Verdaux

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

public struct ELF64VersionDefAux: LayoutWrapper {
    public typealias Layout = Elf64_Verdaux

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

extension ELF32VersionDefAux: ELFVersionDefAuxProtocol {
    public var nameOffset: Int {
        numericCast(layout.vda_name)
    }

    public var nextOffset: Int {
        numericCast(layout.vda_next)
    }
}

extension ELF32VersionDefAux {
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

    public func name(in elf: ELFFile) -> String? {
        guard let dynamics = elf.dynamics32,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: nameOffset)?.string
    }
}

extension ELF32VersionDefAux {
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

    public func name(in elf: ELFImage) -> String? {
        guard let dynamics = elf.dynamics32,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: nameOffset)?.string
    }
}

extension ELF64VersionDefAux: ELFVersionDefAuxProtocol {
    public var nameOffset: Int {
        numericCast(layout.vda_name)
    }

    public var nextOffset: Int {
        numericCast(layout.vda_next)
    }
}

extension ELF64VersionDefAux {
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

    public func name(in elf: ELFFile) -> String? {
        guard let dynamics = elf.dynamics64,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: nameOffset)?.string
    }
}

extension ELF64VersionDefAux {
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

    public func name(in elf: ELFImage) -> String? {
        guard let dynamics = elf.dynamics64,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: nameOffset)?.string
    }
}
