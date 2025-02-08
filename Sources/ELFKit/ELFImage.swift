//
//  ELFImage.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

public struct ELFImage: ELFRepresentable {
    /// Address of ELF header start
    public let ptr: UnsafeRawPointer

    /// A boolean value that indicates whether ELF is a 64-bit architecture.
    public var is64Bit: Bool { header.identifier.class == ._64 }

    /// Size of ELF header. [byte]
    public var headerSize: Int {
        is64Bit ? ELF64Header.layoutSize : ELF32Header.layoutSize
    }

    /// ELF header
    public let header: ELFHeader

    public init(ptr: UnsafeRawPointer) throws {
        self.ptr = .init(ptr)

        let identifier: HeaderIdentifier = ptr.autoBoundPointee()

        let header: ELFHeader
        switch identifier.class {
        case ._32:
            let _header: ELF32Header = ptr.autoBoundPointee()
            header = ._32(_header)
        case ._64:
            let _header: ELF64Header = ptr.autoBoundPointee()
            header = ._64(_header)
        default:
            throw ELFKitError.invalidFile
        }

        self.header = header
    }
}

#if os(Linux)
extension ELFImage {
    public init?(name: String) {
        var image = Ref<ELFImage?>(targetName: name, value: nil)

        let callback: IteratePhdrCallback = { info, size, _image in
            guard let info = info?.pointee else { return 0 }
            guard let path = info.dlpi_name.flatMap({ String(cString: $0) }) else {
                return 0
            }
            let imageName = path
                .components(separatedBy: "/")
                .last?
                .components(separatedBy: ".")
                .first

            guard let _image else { return 1 }
            let image = _image.assumingMemoryBound(to: Ref<ELFImage?>.self)

            guard imageName == image.pointee.targetName else { return 0 }

            guard let ptr = UnsafeRawPointer(bitPattern: UInt(info.dlpi_addr)) else {
                return 1 // stop iterate
            }
            guard let elf = try? ELFImage(ptr: ptr) else { return 1 }
            image.pointee.set(elf)

            return 1
        }

        dl_iterate_phdr(callback, &image)

        guard let image = image.value else { return nil }
        self = image
    }
}

fileprivate class Ref<T> {
    let targetName: String
    private(set) var value: T

    init(targetName: String, value: T) {
        self.targetName = targetName
        self.value = value
    }

    func set(_ value: T) {
        self.value = value
    }
}
#endif

extension ELFImage {
    public var programs32: MemorySequence<ELF32ProgramHeader>? {
        guard !is64Bit else { return nil }
        return .init(
            basePointer: ptr
                .advanced(by: header.programTableOffset)
                .assumingMemoryBound(to: ELF32ProgramHeader.self),
            numberOfElements: header.numberOfPrograms
        )
    }

    public var programs64: MemorySequence<ELF64ProgramHeader>? {
        guard is64Bit else { return nil }
        return .init(
            basePointer: ptr
                .advanced(by: header.programTableOffset)
                .assumingMemoryBound(to: ELF64ProgramHeader.self),
            numberOfElements: header.numberOfPrograms
        )
    }

    public var programs: [any ELFProgramHeaderProtocol] {
        if let programs64 {
            return Array(programs64)
        } else if let programs32 {
            return Array(programs32)
        }
        return []
    }
}

//extension ELFImage {
//    public var sections32: MemorySequence<ELF32SectionHeader>? {
//        guard !is64Bit else { return nil }
//        return .init(
//            basePointer: ptr
//                .advanced(by: header.sectionTableOffset)
//                .assumingMemoryBound(to: ELF32SectionHeader.self),
//            numberOfElements: header.numberOfSections
//        )
//    }
//
//    public var sections64: MemorySequence<ELF64SectionHeader>? {
//        guard is64Bit else { return nil }
//        return .init(
//            basePointer: ptr
//                .advanced(by: header.sectionTableOffset)
//                .assumingMemoryBound(to: ELF64SectionHeader.self),
//            numberOfElements: header.numberOfSections
//        )
//    }
//
//    public var sections: [any ELFSectionHeaderProtocol] {
//        if let sections64 {
//            return Array(sections64)
//        } else if let sections32 {
//            return Array(sections32)
//        }
//        return []
//    }
//
//    public var sectionHeaderStrings: Strings? {
//        guard header.sectionNameStringTableIndex < header.numberOfSections else {
//            return nil
//        }
//        if let sections64 {
//            let section = sections64[header.sectionNameStringTableIndex]
//            return section._strings(in: self)
//        } else if let sections32 {
//            let section = sections32[header.sectionNameStringTableIndex]
//            return section._strings(in: self)
//        }
//        return nil
//    }
//}

extension ELFImage {
    public var dynamics64: Dynamics64? {
        guard is64Bit else { return nil }
//        if let dynamic = sections64?._dynamic {
//            return dynamic._dynamics(in: self)
//        }
        if let dynamic = programs64?._dynamic,
           let wrapped = dynamic._dynamics(in: self) {
            return .init(wrapped)
        }
        return nil
    }

    public var dynamics32: Dynamics32? {
        guard !is64Bit else { return nil }
//        if let dynamic = sections32?._dynamic {
//            return dynamic._dynamics(in: self)
//        }
        if let dynamic = programs32?._dynamic,
           let wrapped = dynamic._dynamics(in: self) {
            return .init(wrapped)
        }
        return nil
    }

    public var dynamics: [any ELFDynamicProtocol]? {
        if is64Bit {
            dynamics64?.map { $0 }
        } else {
            dynamics32?.map { $0 }
        }
    }
}

extension ELFImage {
    public var dynamicSymbols32: MemorySequence<ELF32Symbol>? {
        guard !is64Bit else { return nil }
        return dynamics32?.symbols(in: self)
    }

    public var dynamicSymbols64: MemorySequence<ELF64Symbol>? {
        guard is64Bit else { return nil}
        return dynamics64?.symbols(in: self)
    }

    public var dynamicSymbols: [any ELFSymbolProtocol] {
        if is64Bit, let dynamicSymbols64 {
            return Array(dynamicSymbols64)
        } else if let dynamicSymbols32 {
            return Array(dynamicSymbols32)
        } else {
            return []
        }
    }
}

extension ELFImage {
//    public var stringTable: Strings? {
//        if let sections64,
//           let strtab = sections64._strtab(in: self) {
//            return strtab._strings(in: self)
//        } else if let sections32,
//                  let strtab = sections32._strtab(in: self) {
//            return strtab._strings(in: self)
//        }
//        return nil
//    }

    public var dynamicStringTable: Strings? {
//        if let sections64,
//           let dynstr = sections64._dynstr(in: self) {
//            return dynstr._strings(in: self)
//        } else if let sections32,
//                  let dynstr = sections32._dynstr(in: self) {
//            return dynstr._strings(in: self)
//        }
        if let dynamics64 {
            return dynamics64.strings(in: self)
        } else if let dynamics32 {
            return dynamics32.strings(in: self)
        }
        return nil
    }

//    public var allCStringTables: [Strings] {
//        sections.compactMap {
//            $0._strings(in: self)
//        }
//    }
}

extension ELFImage {
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

extension ELFImage {
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
