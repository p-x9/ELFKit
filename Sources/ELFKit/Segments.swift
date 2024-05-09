//
//  Segments.swift
//  
//
//  Created by p-x9 on 2024/04/29
//  
//

import Foundation

extension Sequence where Element: ELFProgramHeaderProtocol {
    func _dynamic(in elf: ELFFile) -> Element? {
        first(where: { $0.type(inELF: elf.header) == .dynamic })
    }
}
