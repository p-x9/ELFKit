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
    public var type: SegmentType! {
        .init(rawValue: layout.p_type)
    }

    public var osSpecificType: SegmentType.OSSpecific {
        .init(rawValue: numericCast(layout.p_type))
    }

    public var processorSpecificType: SegmentType.ProcessorSpecific {
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
