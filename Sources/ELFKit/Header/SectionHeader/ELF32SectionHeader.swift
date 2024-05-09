//
//  ELF32SectionHeader.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct ELF32SectionHeader: LayoutWrapper {
    public typealias Layout = Elf32_Shdr

    public var layout: Layout
}

extension ELF32SectionHeader: ELFSectionHeaderProtocol {
    public typealias Relocation = ELF32Relocation
    public typealias Note = ELF32Note
    public typealias Dynamics = ELFFile.Dynamics32

    public var nameOffset: Int { numericCast(layout.sh_name) }

    public var _commonType: SectionType? {
        .init(
            rawValue: layout.sh_type,
            osabi: .none,
            machine: .none
        )
    }

    public func type(inELF header: ELFHeader) -> SectionType? {
        guard let osABI = header.osABI,
              let machine = header.machine else {
            return nil
        }
        return .init(
            rawValue: layout.sh_type,
            osabi: osABI,
            machine: machine
        )
    }

    public var flags: SectionFlags {
        .init(rawValue: numericCast(layout.sh_flags))
    }

    public var address: Int { numericCast(layout.sh_addr) }
    public var offset: Int { numericCast(layout.sh_offset) }
    public var size: Int { numericCast(layout.sh_size) }
    public var link: Int { numericCast(layout.sh_link) }
    public var addressAlignment: Int { numericCast(layout.sh_addralign) }
    public var entrySize: Int { numericCast(layout.sh_entsize) }
}

extension ELF32SectionHeader {
    public func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>? {
        switch type(inELF: elf.header) {
        case .rel:
            let count = size / ELF32RelocationInfo.layoutSize
            let sequence: DataSequence<ELF32RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence
                    .map {
                        .general($0)
                    }
            )
        case .rela:
            let count = size / ELF32RelocationAddendInfo.layoutSize
            let sequence: DataSequence<ELF32RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(offset),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence
                    .map {
                        .addend($0)
                    }
            )
        default:
            return nil
        }
    }
}

// MARK: - Version Defs
extension ELF32SectionHeader {
    public func _versionDef(in elf: ELFFile) -> ELF32VersionDef? {
        guard [.gnu_verdef, .sunw_verdef].contains(type(inELF: elf.header)) else {
            return nil
        }
        let layout: ELF32VersionDef.Layout = elf.fileHandle.read(
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
extension ELF32SectionHeader {
    public func _versionNeed(in elf: ELFFile) -> ELF32VersionNeed? {
        guard [.gnu_verneed, .sunw_verneed].contains(type(inELF: elf.header)) else {
            return nil
        }
        let layout: ELF32VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(offset)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: offset
        )
    }
}
