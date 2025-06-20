//
//  ELFVersionDef.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct ELF32VersionDef: LayoutWrapper {
    public typealias Layout = Elf32_Verdef

    public var layout: Layout
    public let _index: Int
    public let _offset: Int
}

public struct ELF64VersionDef: LayoutWrapper {
    public typealias Layout = Elf64_Verdef

    public var layout: Layout
    public let _index: Int
    public let _offset: Int

}

extension ELF32VersionDef: ELFVersionDefProtocol {
    public typealias Aux = ELF32VersionDefAux

    public var flags: VersionFlags {
        .init(rawValue: layout.vd_flags)
    }

    public var versionIndex: Int {
        numericCast(layout.vd_ndx)
    }

    public var numberOfAux: Int {
        numericCast(layout.vd_cnt)
    }

    public var hash: Int {
        numericCast(layout.vd_hash)
    }

    public var auxOffset: Int {
        numericCast(layout.vd_aux)
    }

    public var nextOffset: Int {
        numericCast(layout.vd_next)
    }
}

extension ELF32VersionDef {
    public func _next(in elf: ELFFile) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        if let dynamics = elf.dynamics32,
            let max = dynamics.numberOfVersionDefs,
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

        let offset = _offset + numericCast(layout.vd_aux)
        let layout: Aux.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

extension ELF32VersionDef {
    public func _next(in elf: ELFImage) -> Self? {
        guard nextOffset != 0 else {
            return nil
        }
        if let dynamics = elf.dynamics32,
            let max = dynamics.numberOfVersionDefs,
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

        let offset = _offset + numericCast(layout.vd_aux)
        let layout: Aux.Layout = elf.ptr
            .advanced(by: offset)
            .autoBoundPointee()
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

extension ELF64VersionDef: ELFVersionDefProtocol {
    public typealias Aux = ELF64VersionDefAux

    public var flags: VersionFlags {
        .init(rawValue: layout.vd_flags)
    }

    public var versionIndex: Int {
        numericCast(layout.vd_ndx)
    }

    public var numberOfAux: Int {
        numericCast(layout.vd_cnt)
    }

    public var hash: Int {
        numericCast(layout.vd_hash)
    }

    public var auxOffset: Int {
        numericCast(layout.vd_aux)
    }

    public var nextOffset: Int {
        numericCast(layout.vd_next)
    }
}

extension ELF64VersionDef {
    public func _next(in elf: ELFFile) -> Self? {
        guard let dynamics = elf.dynamics64,
              let max = dynamics.numberOfVersionDefs,
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

        let offset = _offset + numericCast(layout.vd_aux)
        let layout: Aux.Layout = try! elf.fileHandle.read(
            offset: offset
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

extension ELF64VersionDef {
    public func _next(in elf: ELFImage) -> Self? {
        guard let dynamics = elf.dynamics64,
              let max = dynamics.numberOfVersionDefs,
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

        let offset = _offset + numericCast(layout.vd_aux)
        let layout: Aux.Layout = elf.ptr
            .advanced(by: offset)
            .autoBoundPointee()
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}
