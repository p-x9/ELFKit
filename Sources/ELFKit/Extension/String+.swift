//
//  String+.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation

extension String {
    typealias UInt8Tuple16 = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    init(tuple: UInt8Tuple16) {
        self = withUnsafePointer(to: tuple) {
            let size = MemoryLayout<UInt8Tuple16>.size
            let data = Data(bytes: $0, count: size) + [0]
            return String(cString: data) ?? ""
        }
    }
}

extension String {
    init?(cString data: Data) {
        guard !data.isEmpty else { return nil }
        self = data.withUnsafeBytes {
            let ptr = $0.baseAddress!.assumingMemoryBound(to: CChar.self)
            return String(cString: ptr)
        }
    }
}
