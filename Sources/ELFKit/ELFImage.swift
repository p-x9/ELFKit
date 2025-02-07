//
//  ELFImage.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

public struct ELFImage {
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
