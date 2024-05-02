//
//  ELF64ProgramHeader.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct ELF64ProgramHeader: LayoutWrapper {
    public typealias Layout = Elf64_Phdr

    public var layout: Layout
}

extension ELF64ProgramHeader: ELFProgramHeaderProtocol {
    public var type: ProgramType! {
        .init(rawValue: layout.p_type)
    }

    public var osSpecificType: ProgramType.OSSpecific {
        .init(rawValue: numericCast(layout.p_type))
    }

    public var processorSpecificType: ProgramType.ProcessorSpecific {
        .init(rawValue: numericCast(layout.p_type))
    }

    public var flags: ProgramFlags {
        .init(rawValue: numericCast(layout.p_flags))
    }

    public var offset: Int { numericCast(layout.p_offset) }
    public var virtualAddress: Int { numericCast(layout.p_vaddr) }
    public var physicalAddress: Int { numericCast(layout.p_paddr) }
    public var fileSize: Int { numericCast(layout.p_filesz) }
    public var memorySize: Int { numericCast(layout.p_memsz) }
    public var align: Int { numericCast(layout.p_align) }
}
