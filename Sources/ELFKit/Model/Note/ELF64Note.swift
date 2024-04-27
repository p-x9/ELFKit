//
//  ELF64Note.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation
import ELFKitC

public struct ELF64Note {
    public let data: Data
    public let header: ELF64NoteHeader

    public init?(data: Data) {
        guard data.count >= ELF64NoteHeader.layoutSize else {
            return nil
        }
        self.data = data
        self.header = data.withUnsafeBytes {
            let laytou = $0.load(as: ELF64NoteHeader.Layout.self)
            return .init(layout: laytou)
        }
    }
}

extension ELF64Note: ELFNoteProtocol {
    public var name: String? {
        let data = data.advanced(by: header.layoutSize)
        return String(cString: data)
    }

    public var descriptionData: Data? {
        let offset = header.layoutSize + header.nameSize
        let size = header.descriptionSize
        guard data.count >= offset + size else {
            return nil
        }
        return data[offset..<offset + size]
    }
}
