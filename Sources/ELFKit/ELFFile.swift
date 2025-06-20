//
//  ELFFile.swift
//
//
//  Created by p-x9 on 2024/04/26
//
//

import Foundation
#if compiler(>=6.0) || (compiler(>=5.10) && hasFeature(AccessLevelOnImport))
internal import FileIO
#else
@_implementationOnly import FileIO
#endif

public final class ELFFile: ELFRepresentable {
    typealias File = MemoryMappedFile

    /// URL of the file actually loaded
    public let url: URL

    let fileHandle: File

    /// A boolean value that indicates whether ELF is a 64-bit architecture.
    public var is64Bit: Bool { header.identifier.class == ._64 }

    /// Size of ELF header. [byte]
    public var headerSize: Int {
        is64Bit ? ELF64Header.layoutSize : ELF32Header.layoutSize
    }

    /// ELF header
    public let header: ELFHeader

    public init(url: URL) throws {
        self.url = url
        self.fileHandle = try File.open(
            url: url,
            isWritable: false
        )

        guard let identifier: HeaderIdentifier = .init(
            layout: try fileHandle.read(offset: 0)
        ) else { throw ELFKitError.invalidFile }

        let header: ELFHeader
        switch identifier.class {
        case ._32:
            let _header: ELF32Header = try fileHandle.read(
                offset: 0
            )
            header = ._32(_header)
        case ._64:
            let _header: ELF64Header = try fileHandle.read(
                offset: 0
            )
            header = ._64(_header)
        default:
            throw ELFKitError.invalidFile
        }

        self.header = header
    }
}

extension ELFFile {
    public var programs32: DataSequence<ELF32ProgramHeader>? {
        guard !is64Bit else { return nil }
        return fileHandle.readDataSequence(
            offset: numericCast(header.programTableOffset),
            numberOfElements: header.numberOfPrograms
        )
    }

    public var programs64: DataSequence<ELF64ProgramHeader>? {
        guard is64Bit else { return nil }
        return fileHandle.readDataSequence(
            offset: numericCast(header.programTableOffset),
            numberOfElements: header.numberOfPrograms
        )
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

    public var sections: [any ELFSectionHeaderProtocol] {
        if let sections64 {
            return Array(sections64)
        } else if let sections32 {
            return Array(sections32)
        }
        return []
    }

    public var sectionHeaderStrings: Strings? {
        guard header.sectionNameStringTableIndex < header.numberOfSections else {
            return nil
        }
        if let sections64 {
            let section = sections64[header.sectionNameStringTableIndex]
            return section._strings(in: self)
        } else if let sections32 {
            let section = sections32[header.sectionNameStringTableIndex]
            return section._strings(in: self)
        }
        return nil
    }
}

extension ELFFile {
    public var dynamics64: Dynamics64? {
        guard is64Bit else { return nil }
        if let dynamic = sections64?._dynamic,
           let wrapped = dynamic._dynamics(in: self) {
            return .init(wrapped)
        }
        if let dynamic = programs64?._dynamic,
           let wrapped = dynamic._dynamics(in: self) {
            return .init(wrapped)
        }
        return nil
    }

    public var dynamics32: Dynamics32? {
        guard !is64Bit else { return nil }
        if let dynamic = sections32?._dynamic,
           let wrapped = dynamic._dynamics(in: self) {
            return .init(wrapped)
        }
        if let dynamic = programs32?._dynamic,
           let wrapped = dynamic._dynamics(in: self) {
            return .init(wrapped)
        }
        return nil
    }
}

extension ELFFile {
    public var symbols32: DataSequence<ELF32Symbol>? {
        guard !is64Bit,
              let _symtab = sections32?._symtab else {
            return nil
        }
        return fileHandle.readDataSequence(
            offset: numericCast(_symtab.offset),
            numberOfElements: _symtab.size / ELF32Symbol.layoutSize
        )
    }

    public var symbols64: DataSequence<ELF64Symbol>? {
        guard is64Bit,
              let _symtab = sections64?._symtab else {
            return nil
        }
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

extension ELFFile {
    public var dynamicSymbols32: DataSequence<ELF32Symbol>? {
        guard !is64Bit,
              let _dysym = sections32?._dynsym else {
            return dynamics32?.symbols(in: self)
        }
        return fileHandle.readDataSequence(
            offset: numericCast(_dysym.offset),
            numberOfElements: _dysym.size / ELF32Symbol.layoutSize
        )
    }

    public var dynamicSymbols64: DataSequence<ELF64Symbol>? {
        guard is64Bit,
              let _dysym = sections64?._dynsym else {
            return dynamics64?.symbols(in: self)
        }
        return fileHandle.readDataSequence(
            offset: numericCast(_dysym.offset),
            numberOfElements: _dysym.size / ELF64Symbol.layoutSize
        )
    }
}

extension ELFFile {
    public var stringTable: Strings? {
        if let sections64,
           let strtab = sections64._strtab(in: self) {
            return strtab._strings(in: self)
        } else if let sections32,
                  let strtab = sections32._strtab(in: self) {
            return strtab._strings(in: self)
        }
        return nil
    }

    public var dynamicStringTable: Strings? {
        if let sections64,
           let dynstr = sections64._dynstr(in: self) {
            return dynstr._strings(in: self)
        } else if let sections32,
                  let dynstr = sections32._dynstr(in: self) {
            return dynstr._strings(in: self)
        }
        if let dynamics64 {
            return dynamics64.strings(in: self)
        } else if let dynamics32 {
            return dynamics32.strings(in: self)
        }
        return nil
    }

    public var allCStringTables: [Strings] {
        sections.compactMap {
            $0._strings(in: self)
        }
    }
}

extension ELFFile {
    /// List of runpaths
    public var rpaths: [String] {
        if let dynamics64 {
            let rpaths = dynamics64.rpaths(in: self)
            let runpaths = dynamics64.runpaths(in: self)
            return rpaths + runpaths
        }
        if let dynamics32 {
            let rpaths = dynamics32.rpaths(in: self)
            let runpaths = dynamics32.runpaths(in: self)
            return rpaths + runpaths
        }
        return []
    }
}

extension ELFFile {
    /// List of depended shared objects.
    public var dependencies: [String] {
        if let dynamics64 {
            return dynamics64.neededs(in: self)
        }
        if let dynamics32 {
            return dynamics32.neededs(in: self)
        }
        return []
    }
}

extension ELFFile {
    public func fileOffset(of virtualAddress: Int) -> Int? {
        for program in self.programs {
            if virtualAddress >= program.virtualAddress & -program.align,
               virtualAddress < program.virtualAddress + program.memorySize {
                let diff = program.virtualAddress - program.offset
                return virtualAddress - diff
            }
        }

        for section in self.sections {
            if virtualAddress >= section.address & -section.addressAlignment,
               virtualAddress < section.address + section.size {
                let diff = section.address - section.offset
                return virtualAddress - diff
            }
        }

        return nil
    }
}
