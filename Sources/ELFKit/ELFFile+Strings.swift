//
//  ELFFile+Strings.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
#if compiler(>=6.0) || (compiler(>=5.10) && hasFeature(AccessLevelOnImport))
internal import FileIO
#else
@_implementationOnly import FileIO
#endif

extension ELFFile {
    public typealias UnicodeStrings = BinaryParseSupport.UnicodeStrings
    public typealias Strings = UnicodeStrings<UTF8>
}

extension ELFFile.UnicodeStrings {
    init(
        elf: ELFFile,
        offset: Int,
        size: Int,
        isSwapped: Bool
    ) {
        let fileSlice = try! elf.fileHandle.fileSlice(
            offset: offset,
            length: size
        )
        self.init(
            source: fileSlice,
            offset: offset,
            size: size,
            isSwapped: isSwapped
        )
    }
}
