//
//  FileHandle+.swift
//
//
//  Created by p-x9 on 2024/01/20.
//
//

import Foundation

extension FileHandle {
    func read<Element>(
        offset: UInt64,
        swapHandler: ((inout Data) -> Void)? = nil
    ) -> Element where Element: LayoutWrapper {
        seek(toFileOffset: offset)
        var data = readData(
            ofLength: Element.layoutSize
        )
        if let swapHandler { swapHandler(&data) }
        return data.withUnsafeBytes {
            $0.load(as: Element.self)
        }
    }

    func read<Element>(
        offset: UInt64,
        swapHandler: ((inout Data) -> Void)? = nil
    ) -> Element {
        seek(toFileOffset: offset)
        var data = readData(
            ofLength: MemoryLayout<Element>.size
        )
        if let swapHandler { swapHandler(&data) }
        return data.withUnsafeBytes {
            $0.load(as: Element.self)
        }
    }
}

extension FileHandle {
    func readString(
        offset: UInt64,
        size: Int
    ) -> String? {
        let data = readData(
            offset: offset,
            size: size
        )
        return String(cString: data)
    }

    func readData(
        offset: UInt64,
        size: Int
    ) -> Data {
        seek(toFileOffset: offset)
        return readData(
            ofLength: size
        )
    }
}
