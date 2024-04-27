//
//  ELF32NoteHeader.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public struct ELF32NoteHeader: LayoutWrapper {
    public typealias Layout = Elf32_Nhdr

    public var layout: Layout
}

extension ELF32NoteHeader: ELFNoteHeaderProtocol {
    public var nameSize: Int {
        numericCast(layout.n_namesz)
    }
    
    public var descriptionSize: Int {
        numericCast(layout.n_descsz)
    }
    
    public var type: Int {
        numericCast(layout.n_type)
    }
}
