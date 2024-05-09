//
//  ELF64Dynamic.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public struct ELF64Dynamic: LayoutWrapper {
    public typealias Layout = Elf64_Dyn

    public var layout: Layout
}

extension ELF64Dynamic: ELFDynamicProtocol {
    public var _commonTag: DynamicTag? {
        .init(
            rawValue: numericCast(layout.d_tag),
            osabi: .none,
            machine: .none
        )
    }

    public func tag(inELF header: ELFHeader) -> DynamicTag? {
        guard let osABI = header.osABI,
              let machine = header.machine else {
            return nil
        }
        return .init(
            rawValue: numericCast(layout.d_tag),
            osabi: osABI,
            machine: machine
        )
    }

    public var value: Int {
        numericCast(layout.d_un.d_val)
    }

    public var pointer: Int {
        numericCast(layout.d_un.d_ptr)
    }
}
