//
//  ELFImage+Dynamics.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

import Foundation
import ELFKitC

extension ELFImage {
    public struct Dynamics32: ELFImageDynamicsSequence {
        public typealias Dynamic = ELF32Dynamic

        public typealias Element = ELF32Dynamic
        public typealias Iterator = MemorySequence<Dynamic>.Iterator

        public let sequence: WrappedSequence

        public init(_ sequence: WrappedSequence) {
            self.sequence = sequence
        }
    }

    public struct Dynamics64: ELFImageDynamicsSequence {
        public typealias Dynamic = ELF64Dynamic
        public typealias Element = ELF64Dynamic
        public typealias Iterator = MemorySequence<Dynamic>.Iterator

        public let sequence: WrappedSequence

        public init(_ sequence: WrappedSequence) {
            self.sequence = sequence
        }
    }
}
