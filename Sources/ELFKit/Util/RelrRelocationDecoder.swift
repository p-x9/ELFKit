//
//  RelrRelocationDecoder.swift
//  ELFKit
//
//  Created by Codex on 2026/03/02.
//
//

import Foundation

enum _ELFRelrRelocationDecoder {
    static func entries<Entry>(
        _ values: some Sequence<Entry>
    ) -> [ELFRelrEntry] where Entry: FixedWidthInteger {
        values.map { value in
            let rawValue: UInt64 = numericCast(value)
            if value & 1 == 0 {
                return .address(rawValue)
            }
            return .bitmap(rawValue)
        }
    }

    static func decode<Entry>(
        _ values: some Sequence<Entry>
    ) -> [ELFRelrRelocation] where Entry: FixedWidthInteger {
        decode(
            entries(values),
            wordSize: MemoryLayout<Entry>.size
        )
    }

    static func decode(
        _ entries: some Sequence<ELFRelrEntry>,
        wordSize: Int
    ) -> [ELFRelrRelocation] {
        let bitmapBitCount = (wordSize * 8) - 1

        var nextOffset = 0
        var relocations: [ELFRelrRelocation] = []

        for entry in entries {
            switch entry {
            case let .address(rawOffset):
                let offset: Int = numericCast(rawOffset)
                relocations.append(.init(offset: offset))
                nextOffset = offset + wordSize

            case let .bitmap(rawValue):
                let bitmap = rawValue >> 1
                for bitIndex in 0..<bitmapBitCount {
                    let mask = UInt64(1) << bitIndex
                    guard bitmap & mask != 0 else { continue }
                    relocations.append(
                        .init(offset: nextOffset + (bitIndex * wordSize))
                    )
                }
                nextOffset += bitmapBitCount * wordSize
            }
        }

        return relocations
    }
}
