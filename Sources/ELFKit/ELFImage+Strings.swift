//
//  ELFImage+Strings.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

extension ELFImage {
    public typealias Strings = UnicodeStrings<UTF8>

    public struct UnicodeStrings<Encoding: _UnicodeEncoding>: StringTable {
        public let basePointer: UnsafePointer<Encoding.CodeUnit>
        public let tableSize: Int

        public let isLittleEndian: Bool

        init(
            basePointer: UnsafePointer<Encoding.CodeUnit>,
            tableSize: Int,
            isLittleEndian: Bool = false
        ) {
            self.basePointer = basePointer
            self.tableSize = tableSize
            self.isLittleEndian = isLittleEndian
        }

        public func makeIterator() -> Iterator {
            Iterator(
                basePointer: basePointer,
                tableSize: tableSize,
                isLittleEndian: isLittleEndian
            )
        }
    }
}

extension ELFImage.UnicodeStrings {
    public struct Iterator: IteratorProtocol {
        public typealias Element = StringTableEntry

        private let basePointer: UnsafePointer<Encoding.CodeUnit>
        private let tableSize: Int
        private let isLittleEndian: Bool

        private var nextPointer: UnsafePointer<Encoding.CodeUnit>

        init(
            basePointer: UnsafePointer<Encoding.CodeUnit>,
            tableSize: Int,
            isLittleEndian: Bool
        ) {
            self.basePointer = basePointer
            self.tableSize = tableSize
            self.isLittleEndian = isLittleEndian
            self.nextPointer = basePointer
        }

        public mutating func next() -> Element? {
            let offset = Int(bitPattern: nextPointer) - Int(bitPattern: basePointer)
            if offset >= tableSize {
                return nil
            }
            var (string, nextOffset) = nextPointer.readString(
                as: Encoding.self
            )

            if isLittleEndian {
                let data = Data(bytes: nextPointer, count: offset)
                string = data.withUnsafeBytes {
                    let baseAddress = $0.baseAddress!
                        .assumingMemoryBound(to: Encoding.CodeUnit.self)
                    return .init(
                        decodingCString: baseAddress,
                        as: Encoding.self
                    )
                }
            }

            nextPointer = nextPointer.advanced(
                by: nextOffset / MemoryLayout<Encoding.CodeUnit>.size
            )

            return .init(string: string, offset: offset)
        }
    }
}

extension ELFImage.Strings {
    func string(at offset: Int) -> Element? {
        guard tableSize >= offset else { return nil }
        let string = String(
            cString: UnsafeRawPointer(basePointer)
                .advanced(by: offset)
                .assumingMemoryBound(to: CChar.self)
        )
        return .init(string: string, offset: offset)
    }
}
