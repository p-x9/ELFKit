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

    public var type: SectionType? {
        .init(rawValue: numericCast(layout.sh_type))
    }

    public var osSpecificType: SectionType.OSSpecific {
        .init(rawValue: numericCast(layout.sh_type))
    }

    public var processorSpecificType: SectionType.ProcessorSpecific {
        .init(rawValue: numericCast(layout.sh_type))
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

extension ELF64SectionHeader {
    public func _relocations(in elf: ELFFile) -> AnyRandomAccessCollection<Relocation>? {
        switch type {
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
