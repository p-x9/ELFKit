//
//  ELFVersionNeed.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct ELF32VersionNeed: LayoutWrapper, Sendable {
    public typealias Layout = Elf32_Verneed

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

public struct ELF64VersionNeed: LayoutWrapper, Sendable {
    public typealias Layout = Elf64_Verneed

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

extension ELF32VersionNeed: ELFVersionNeedProtocol {
    public typealias Aux = ELF32VersionNeedAux

    public var fileNameOffset: Int {
        numericCast(layout.vn_file)
    }

    public var numberOfAux: Int {
        numericCast(layout.vn_cnt)
    }

    public var auxOffset: Int {
        numericCast(layout.vn_aux)
    }

    public var nextOffset: Int {
        numericCast(layout.vn_next)
    }
}

extension ELF32VersionNeed {
    public func fileName(in elf: ELFFile) -> String? {
        guard let dynamics = elf.dynamics32,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: fileNameOffset)?.string
    }

    public func _next(in elf: ELFFile) -> Self? {
        guard let dynamics = elf.dynamics32,
              let max = dynamics.numberOfVersionNeeds,
              _index + 1 < max,
              nextOffset != 0 else {
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

    public func _aux(in elf: ELFFile) -> Aux? {
        guard numberOfAux > 0 else { return nil }

        let offset = _offset + numericCast(layout.vn_aux)
        let layout: ELF32VersionNeedAux.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

extension ELF32VersionNeed {
    public func fileName(in elf: ELFImage) -> String? {
        guard let dynamics = elf.dynamics32,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: fileNameOffset)?.string
    }

    public func _next(in elf: ELFImage) -> Self? {
        guard let dynamics = elf.dynamics32,
              let max = dynamics.numberOfVersionNeeds,
              _index + 1 < max,
              nextOffset != 0 else {
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

    public func _aux(in elf: ELFImage) -> Aux? {
        guard numberOfAux > 0 else { return nil }

        let offset = _offset + numericCast(layout.vn_aux)
        let layout: ELF32VersionNeedAux.Layout = elf.ptr
            .advanced(by: offset)
            .autoBoundPointee()
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

extension ELF64VersionNeed: ELFVersionNeedProtocol {
    public typealias Aux = ELF64VersionNeedAux

    public var fileNameOffset: Int {
        numericCast(layout.vn_file)
    }

    public var numberOfAux: Int {
        numericCast(layout.vn_cnt)
    }

    public var auxOffset: Int {
        numericCast(layout.vn_aux)
    }

    public var nextOffset: Int {
        numericCast(layout.vn_next)
    }
}

extension ELF64VersionNeed {
    public func fileName(in elf: ELFFile) -> String? {
        guard let dynamics = elf.dynamics64,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: fileNameOffset)?.string
    }

    public func _next(in elf: ELFFile) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        if let dynamics = elf.dynamics64,
           let max = dynamics.numberOfVersionNeeds,
           _index + 1 >= max {
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

    public func _aux(in elf: ELFFile) -> Aux? {
        guard numberOfAux > 0 else { return nil }

        let offset = _offset + numericCast(layout.vn_aux)
        let layout: ELF64VersionNeedAux.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

extension ELF64VersionNeed {
    public func fileName(in elf: ELFImage) -> String? {
        guard let dynamics = elf.dynamics64,
              let strings = dynamics.strings(in: elf) else {
            return nil
        }
        return strings.string(at: fileNameOffset)?.string
    }

    public func _next(in elf: ELFImage) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        if let dynamics = elf.dynamics64,
           let max = dynamics.numberOfVersionNeeds,
           _index + 1 >= max {
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

    public func _aux(in elf: ELFImage) -> Aux? {
        guard numberOfAux > 0 else { return nil }

        let offset = _offset + numericCast(layout.vn_aux)
        let layout: ELF64VersionNeedAux.Layout = elf.ptr
            .advanced(by: offset)
            .autoBoundPointee()
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}
