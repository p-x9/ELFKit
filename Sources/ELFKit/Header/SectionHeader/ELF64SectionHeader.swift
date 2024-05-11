//
//  ELF64SectionHeader.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct ELF64SectionHeader: LayoutWrapper {
    public typealias Layout = Elf64_Shdr

    public var layout: Layout
}

extension ELF64SectionHeader: ELFSectionHeaderProtocol {
    public typealias Relocation = ELF64Relocation
    public typealias Note = ELF64Note
    public typealias Dynamics = ELFFile.Dynamics64

    public var nameOffset: Int { numericCast(layout.sh_name) }

    public var _commonType: SectionType? {
        .init(
            rawValue: layout.sh_type,
            osabi: .none,
            machine: .none
        )
    }

    public func type(inELF header: ELFHeader) -> SectionType? {
        .init(
            rawValue: layout.sh_type,
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var _commonFlags: SectionFlags {
        .init(
            rawValue: numericCast(layout.sh_flags),
            osabi: .none,
            machine: .none
        )
    }

    public func flags(inELF header: ELFHeader) -> SectionFlags {
        .init(
            rawValue: numericCast(layout.sh_flags),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var address: Int { numericCast(layout.sh_addr) }
    public var offset: Int { numericCast(layout.sh_offset) }
    public var size: Int { numericCast(layout.sh_size) }
    public var link: Int { numericCast(layout.sh_link) }
    public var addressAlignment: Int { numericCast(layout.sh_addralign) }
    public var entrySize: Int { numericCast(layout.sh_entsize) }
}

extension ELF64SectionHeader {
    public func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>? {
        switch type(inELF: elf.header) {
        case .rel:
            let count = size / ELF64RelocationInfo.layoutSize
            let sequence: DataSequence<ELF64RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        case .rela:
            let count = size / ELF64RelocationAddendInfo.layoutSize
            let sequence: DataSequence<ELF64RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
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
extension ELF64SectionHeader {
    public func _versionDef(in elf: ELFFile) -> ELF64VersionDef? {
        // name: .gnu.* or .SUNW_*
        guard [.gnu_verdef, .sunw_verdef].contains(type(inELF: elf.header)) else {
            return nil
        }
        let layout: ELF64VersionDef.Layout = elf.fileHandle.read(
            offset: numericCast(offset)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}

// MARK: - Verson Needs
extension ELF64SectionHeader {
    public func _versionNeed(in elf: ELFFile) -> ELF64VersionNeed? {
        guard [.gnu_verneed, .sunw_verneed].contains(type(inELF: elf.header)) else {
            return nil
        }
        let layout: ELF64VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(offset)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}
