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
}
