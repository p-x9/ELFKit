//
//  ELFImage+static.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//
//

#if os(Linux)

import Foundation

public typealias IteratePhdrCallback = @convention(c) (_ info: UnsafeMutablePointer<dl_phdr_info>?, _ size: Int, _ data: UnsafeMutableRawPointer?) -> Int32

extension ELFImage {
    public static var images: [ELFImage] {
        var images = Ref<ELFImage>(values: [])

        let callback: IteratePhdrCallback = { info, size, _images in
            guard let info = info?.pointee else { return 0 }
            guard let ptr = UnsafeRawPointer(bitPattern: UInt(info.dlpi_addr)) else {
                return 0
            }
            guard let elf = try? ELFImage(ptr: ptr) else { return 0 }

            if let _images {
                let images = _images.assumingMemoryBound(to: Ref<ELFImage>.self)
                images.pointee.append(elf)
            }

            return 0
        }

        dl_iterate_phdr(callback, &images)

        return images.values
    }
}

fileprivate class Ref<T> {
    private(set) var values: [T]

    init(values: [T]) {
        self.values = values
    }

    func append(_ value: T) {
        values.append(value)
    }
}

#endif
