//
//  GnuHardwareCapabilities.swift
//
//
//  Created by p-x9 on 2024/05/05
//  
//

import Foundation

public struct GnuHardwareCapabilities: Sendable {
    public let numberOfEntries: Int
    public let mask: UInt32
    public let entries: [String]
}

extension GnuHardwareCapabilities {
    init?(data: Data) {
        guard data.count >= 8 else { return nil }
        let num_entries = data.withUnsafeBytes {
            $0.load(as: UInt32.self)
        }
        let mask = data.withUnsafeBytes {
            $0.load(fromByteOffset: 4, as: UInt32.self)
        }
        guard let entries = String(
            data: data.advanced(by: 8),
            encoding: .utf8
        ) else {
            return nil
        }
        self.numberOfEntries = numericCast(num_entries)
        self.mask = mask
        self.entries = entries.components(separatedBy: .newlines)
    }
}
