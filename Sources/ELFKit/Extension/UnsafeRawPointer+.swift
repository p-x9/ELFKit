//
//  UnsafeRawPointer+.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation

extension UnsafeRawPointer {
    func autoBoundPointee<Out>() -> Out {
        bindMemory(to: Out.self, capacity: 1).pointee
    }
}
