//
//  ELFImage+Strings.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

extension ELFImage {
    public typealias UnicodeStrings = BinaryParseSupport.UnicodeStrings
    public typealias Strings = UnicodeStrings<UTF8>
}

extension ELFImage.UnicodeStrings {
    init(
        basePointer: UnsafePointer<Encoding.CodeUnit>,
        offset: Int,
        tableSize: Int,
        isLittleEndian: Bool = false
    ) {
        self.init(
            source: MemoryUnicodeStringsSource(
                ptr: .init(basePointer),
                size: tableSize
            ),
            offset: offset,
            size: tableSize,
            isSwapped: !isLittleEndian
        )
    }
}
