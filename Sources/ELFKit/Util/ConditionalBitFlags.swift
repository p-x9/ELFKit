//
//  ConditionalBitFlags.swift
//
//
//  Created by p-x9 on 2024/05/11
//  
//

import Foundation

public protocol ConditionalBitFlags: SetAlgebra {
    associatedtype RawValue: FixedWidthInteger
    associatedtype Element = Bit
    associatedtype Bit: Hashable & CaseIterable & RawRepresentable & CustomStringConvertible where Bit.RawValue == RawValue
    associatedtype ArrayLiteralElement = Element
    var rawValue: RawValue { get set }
    var _bits: Set<Bit> { get set }

    init(rawValue: RawValue, _bits: Set<Bit>)
}

extension ConditionalBitFlags where Element == Bit {
    public func contains(_ member: Element) -> Bool {
        _bits.contains(member)
    }

    public func union(_ other: Self) -> Self {
        .init(
            rawValue: rawValue | other.rawValue,
            _bits: _bits.union(other._bits)
        )
    }

    public func intersection(_ other: Self) -> Self {
        .init(
            rawValue: rawValue & other.rawValue,
            _bits: _bits.intersection(other._bits)
        )
    }

    public func symmetricDifference(_ other: Self) -> Self {
        .init(
            rawValue: rawValue ^ other.rawValue,
            _bits: _bits.symmetricDifference(other._bits)
        )
    }

    public mutating func formUnion(_ other: Self) {
        rawValue = rawValue | other.rawValue
        _bits.formUnion(other._bits)
    }

    public mutating func formIntersection(_ other: Self) {
        rawValue = rawValue & other.rawValue
        _bits.formIntersection(other._bits)
    }

    public mutating func formSymmetricDifference(_ other: Self) {
        rawValue = rawValue ^ other.rawValue
        _bits.formSymmetricDifference(other._bits)
    }

    public init() {
        self.init(rawValue: 0, _bits: [])
    }

    public mutating func insert(_ newMember: __owned Bit) -> (inserted: Bool, memberAfterInsert: Bit) {
        rawValue = rawValue | newMember.rawValue
        return _bits.insert(newMember)
    }

    public mutating func remove(_ member: Bit) -> Bit? {
        rawValue = rawValue & ~member.rawValue
        return _bits.remove(member)
    }

    public mutating func update(with newMember: __owned Bit) -> Bit? {
        rawValue = rawValue | newMember.rawValue
        return _bits.update(with: newMember)
    }
}

extension ConditionalBitFlags {
    public var bits: [Bit] {
        Array(_bits)
    }

    public var unknownBits: RawValue {
        var rawValue = rawValue
        bits.forEach { rawValue &= ~$0.rawValue }
        return rawValue
    }
}
