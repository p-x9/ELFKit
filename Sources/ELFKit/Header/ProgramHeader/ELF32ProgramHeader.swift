//
//  ELF32ProgramHeader.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct ELF32ProgramHeader: LayoutWrapper {
    public typealias Layout = Elf32_Phdr

    public var layout: Layout
}

extension ELF32ProgramHeader: ELFProgramHeaderProtocol {
    public typealias Relocation = ELF32Relocation
    public typealias Note = ELF32Note
    public typealias Dynamics = ELFFile.Dynamics32

    public var _commonType: ProgramType? {
        .init(
            rawValue: layout.p_type,
            osabi: .none,
            machine: .none
        )
    }

    public func type(inELF header: ELFHeader) -> ProgramType? {
        .init(
            rawValue: layout.p_type,
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var _commonFlags: ProgramFlags {
        .init(
            rawValue: numericCast(layout.p_flags),
            osabi: .none,
            machine: .none
        )
    }

    public func flags(inELF header: ELFHeader) -> ProgramFlags {
        .init(
            rawValue: numericCast(layout.p_flags),
            osabi: header.osABI ?? .none,
            machine: header.machine ?? .none
        )
    }

    public var offset: Int { numericCast(layout.p_offset) }
    public var virtualAddress: Int { numericCast(layout.p_vaddr) }
    public var physicalAddress: Int { numericCast(layout.p_paddr) }
    public var fileSize: Int { numericCast(layout.p_filesz) }
    public var memorySize: Int { numericCast(layout.p_memsz) }
    public var align: Int { numericCast(layout.p_align) }
}
