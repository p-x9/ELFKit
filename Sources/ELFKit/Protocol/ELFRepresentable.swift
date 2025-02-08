//
//  ELFRepresentable.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/08
//  
//


import Foundation

public protocol ELFRepresentable {
    associatedtype Programs64: RandomAccessCollection<ELF64ProgramHeader>
    associatedtype Programs32: RandomAccessCollection<ELF32ProgramHeader>

    associatedtype Dynamics64: ELFDynamicsSequence<ELF64Dynamic> where Dynamics64.ELF == Self
    associatedtype Dynamics32: ELFDynamicsSequence<ELF32Dynamic> where Dynamics32.ELF == Self

    associatedtype Symbols64: RandomAccessCollection<ELF64Symbol>
    associatedtype Symbols32: RandomAccessCollection<ELF32Symbol>

    associatedtype Strings: StringTable<UTF8>

    /// A boolean value that indicates whether ELF is a 64-bit architecture.
    var is64Bit: Bool { get }

    /// Size of ELF header. [byte]
    var headerSize: Int { get }

    /// ELF header
    var header: ELFHeader { get }

    /// List of runpaths
    var rpaths: [String] { get }
    /// List of depended dynamic libraries
    var dependencies: [String] { get }

    /// List of segments
    var programs: [any ELFProgramHeaderProtocol] { get }
    /// Sequence of 64-bit architecture segments
    var programs64: Programs64? { get }
    /// Sequence of 32-bit architecture segments
    var programs32: Programs32? { get }

    /// List of dynamics
    var dynamics: [any ELFDynamicProtocol]? { get }
    /// Sequence of 64-bit architecture dynamics
    var dynamics64: Dynamics64? { get }
    /// Sequence of 32-bit architecture dynamics
    var dynamics32: Dynamics32? { get }

    /// List of dynamic symbols
    var dynamicSymbols: [any ELFSymbolProtocol] { get }
    /// Sequence of 64-bit architecture dynamic symbols
    var dynamicSymbols64: Symbols64? { get }
    /// Sequence of 32-bit architecture dynamic symbols
    var dynamicSymbols32: Symbols32? { get }

    /// Sequence of dynamic symbol strings.
    var dynamicStringTable: Strings? { get }
}
