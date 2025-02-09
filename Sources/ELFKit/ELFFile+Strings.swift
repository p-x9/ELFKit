//
//  ELFFile+Strings.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

public protocol StringTable<Encoding>: Sequence<StringTableEntry> {
    associatedtype Encoding: _UnicodeEncoding
}

extension ELFFile {
    public typealias Strings = UnicodeStrings<UTF8>

    public struct UnicodeStrings<Encoding: _UnicodeEncoding>: StringTable {
        public let data: Data

        /// file offset of string table start
        public let offset: Int

        /// size of string table
        public let size: Int

        public let isLittleEndian: Bool

        public func makeIterator() -> Iterator {
            .init(data: data, isLittleEndian: isLittleEndian)
        }
    }
}

extension ELFFile.UnicodeStrings {
    init(
        elf: ELFFile,
        offset: Int,
        size: Int,
        isLittleEndian: Bool = false
    ) {
        let data = elf.fileHandle.readData(
            offset: numericCast(offset),
            size: size
        )
        self.init(
            data: data,
            offset: offset,
            size: size,
            isLittleEndian: isLittleEndian
        )
    }
}

extension ELFFile.UnicodeStrings {
    public struct Iterator: IteratorProtocol {
        public typealias Element = StringTableEntry

        private let data: Data
        private let tableSize: Int
        private let isLittleEndian: Bool

        private var nextOffset: Int

        init(data: Data, isLittleEndian: Bool) {
            self.data = data
            self.tableSize = data.count
            self.isLittleEndian = isLittleEndian
            self.nextOffset = 0
        }

        public mutating func next() -> Element? {
            data.withUnsafeBytes {
                if nextOffset >= tableSize { return nil }
                guard let baseAddress = $0.baseAddress else { return nil }

                let ptr = baseAddress
                    .advanced(by: nextOffset)
                    .assumingMemoryBound(to: Encoding.CodeUnit.self)
                var (string, offset) = ptr.readString(as: Encoding.self)

                if isLittleEndian {
                    let data = Data(bytes: ptr, count: offset)
                    string = data.withUnsafeBytes {
                        let baseAddress = $0.baseAddress!
                            .assumingMemoryBound(to: Encoding.CodeUnit.self)
                        return .init(
                            decodingCString: baseAddress,
                            as: Encoding.self
                        )
                    }
                }

                let result = Element(string: string, offset: nextOffset)

                nextOffset += offset

                return  result
            }
        }
    }
}

extension ELFFile.Strings {
    func string(at offset: Int) -> Element? {
        guard data.count >= offset else { return nil }
        guard let string = String(
            cString: data.advanced(by: offset)
        ) else {
            return nil
        }
        return .init(string: string, offset: offset)
    }
}
