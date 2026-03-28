//
//  ArchiveFile+ELFFile.swift
//  ELFKit
//
//  Created by p-x9 on 2026/03/28
//  
//

import ELFKit
import ObjectArchiveKit

extension ArchiveFile {
    /// Creates `ELFFile` instances for all ELF members contained in the archive.
    ///
    /// NonELF members such as symbol tables are skipped automatically.
    ///
    /// - Returns: An array of `ELFFile` instances for members whose payload starts with a ELF magic.
    /// - Throws: Any error thrown while initializing a `ELFFile`.
    public func elfFiles() throws -> [ELFFile] {
        try members.compactMap { member in
            guard let dataOffset = member.dataOffset(in: self) else {
                throw ObjectArchiveKitError.invalidHeader
            }
            return try? ELFFile(
                url: url,
                headerStartOffset: dataOffset + headerStartOffset,
                name: member.name(in: self)
            )
        }
    }
}
