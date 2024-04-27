//
//  ELFFile.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation

public class ELFFile {
    /// URL of the file actually loaded
    public let url: URL

    let fileHandle: FileHandle

    public var is64Bit: Bool { header.identifier.class == ._64 }
    public var headerSize: Int {
        is64Bit ? ELF64Header.layoutSize : ELF32Header.layoutSize
    }

    public let header: ELFHeader

    init(url: URL) throws {
        self.url = url
        self.fileHandle = try FileHandle(forReadingFrom: url)

        let identifier: HeaderIdentifier = fileHandle.read(
            offset: 0
        )

        let header: ELFHeader
        switch identifier.class {
        case ._32:
            let _header: ELF32Header = fileHandle.read(
                offset: 0
            )
            header = ._32(_header)
        case ._64:
            let _header: ELF64Header = fileHandle.read(
                offset: 0
            )
            header = ._64(_header)
        default:
            throw NSError() // FIXME: Invalid ELF class
        }

        self.header = header
    }

    deinit {
        fileHandle.closeFile()
    }
}

extension ELFFile {
    public var sections32: DataSequence<ELF32SectionHeader>? {
        guard !is64Bit else { return nil }
        return fileHandle.readDataSequence(
            offset: numericCast(header.sectionTableOffset),
            numberOfElements: header.numberOfSections
        )
    }

    public var sections64: DataSequence<ELF64SectionHeader>? {
        guard is64Bit else { return nil }
        return fileHandle.readDataSequence(
            offset: numericCast(header.sectionTableOffset),
            numberOfElements: header.numberOfSections
        )
    }

    public var sections: [ELFSectionHeaderProtocol] {
        if let sections64 {
            return Array(sections64)
        } else if let sections32 {
            return Array(sections32)
        }
        return []
    }

    public var sectionHeaderStrings: Strings? {
        guard sections.indices.contains(header.sectionNameStringTableIndex) else {
            return nil
        }
        let section = sections[header.sectionNameStringTableIndex]
        return section._strings(in: self)
    }
}

extension ELFFile {
    public var symbols32: DataSequence<ELF32Symbol>? {
        guard !is64Bit, let _symtab else { return nil }
        return fileHandle.readDataSequence(
            offset: numericCast(_symtab.offset),
            numberOfElements: _symtab.size / ELF32Symbol.layoutSize
        )
    }

    public var symbols64: DataSequence<ELF64Symbol>? {
        guard is64Bit, let _symtab else { return nil }
        return fileHandle.readDataSequence(
            offset: numericCast(_symtab.offset),
            numberOfElements: _symtab.size / ELF64Symbol.layoutSize
        )
    }

    public var symbols: [ELFSymbolProtocol] {
        if is64Bit, let symbols64 {
            return Array(symbols64)
        } else if let symbols32 {
            return Array(symbols32)
        } else {
            return []
        }
    }
}
