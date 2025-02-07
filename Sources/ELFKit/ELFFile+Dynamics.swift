//
//  ELFFile+Dynamics.swift
//
//
//  Created by p-x9 on 2024/05/02
//  
//

import Foundation
import ELFKitC

extension ELFFile {
    public struct Dynamics32: ELFFileDynamicsSequence {
        public typealias Dynamic = ELF32Dynamic

        public typealias Element = ELF32Dynamic
        public typealias Iterator = DataSequence<Dynamic>.Iterator

        public let sequence: WrappedSequence

        public init(_ sequence: WrappedSequence) {
            self.sequence = sequence
        }
    }

    public struct Dynamics64: ELFFileDynamicsSequence {
        public typealias Dynamic = ELF64Dynamic
        public typealias Element = ELF64Dynamic
        public typealias Iterator = DataSequence<Dynamic>.Iterator

        public let sequence: WrappedSequence

        public init(_ sequence: WrappedSequence) {
            self.sequence = sequence
        }
    }
}
