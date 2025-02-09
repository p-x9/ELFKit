//
//  ELFDynamicsSequence.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/09
//  
//

public protocol ELFDynamicsSequence<Dynamic>: RandomAccessCollection
where Element == Dynamic,
      Index == Int {
    associatedtype ELF: ELFRepresentable
    associatedtype Dynamic: ELFDynamicProtocol, LayoutWrapper

    associatedtype Symbols: RandomAccessCollection<Dynamic.Symbol>
    associatedtype SymbolInfos: RandomAccessCollection<Dynamic.SymbolInfo>
    associatedtype VersionSyms: RandomAccessCollection<Dynamic.VersionSym>
    
    /// Dynamic string table
    ///
    /// Retrieved from dynamic with `DT_STRTAB` tag
    ///
    /// The contents are the same as in the `.dynstr` section.
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: string table
    func strings(in elf: ELF) -> ELF.Strings?
    /// List of depended shared objects.
    ///
    /// Retrieved from dynamic with `DT_NEEDED` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: shared object names
    func neededs(in elf: ELF) -> [String]
    /// List of runpaths
    ///
    /// Retrieved from dynamic with `DT_RPATH` tag
    ///
    /// - Warning: `DT_RUNPATH` is often used instead of `DT_RPATH` in modern linkers
    /// Also consider using the ``runpaths(in:)`` method
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: runpaths
    func rpaths(in elf: ELF) -> [String]
    /// List of runpaths
    ///
    /// Retrieved from dynamic with `DT_RUNPATH` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: runpaths
    func runpaths(in elf: ELF) -> [String]
    /// Shared object name of this ELF
    ///
    /// Retrieved from dynamic with `DT_SONAME` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: shared object name
    func sharedObjectName(in elf: ELF) -> String?
    
    /// Hash table header for dynamic symbol
    ///
    /// Retrieved from dynamic with `DT_HASH` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: hash table header
    func hashTableHeader(in elf: ELF) -> Dynamic.HashTableHeader?
    /// Hash table for dynamic symbol
    ///
    /// Retrieved from dynamic with `DT_HASH` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: hash table
    func hashTable(in elf: ELF) -> Dynamic.HashTable?

    /// GNU Hash table header for dynamic symbol
    ///
    /// Retrieved from dynamic with `DT_GNU_HASH` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: gnu hash table header
    func gnuHashTableHeader(in elf: ELF) -> ELFGnuHashTableHeader?
    /// GNU Hash table for dynamic symbol
    ///
    /// Retrieved from dynamic with `DT_GNU_HASH` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: gnu hash table
    func gnuHashTable(in elf: ELF) -> Dynamic.GnuHashTable?
    
    /// Number of dynamic symbols in this elf
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: number of dynamic symbols
    func numberOfSymbols(in elf: ELF) -> Int?

    /// List of dynamic symbols
    ///
    /// Retrieved from dynamic with `DT_SYMTAB` tag
    ///
    /// - Parameter elf: ELF to which this dynamic belongs
    /// - Returns: dynamic symbols
    func symbols(in elf: ELF) -> Symbols?

    func symbolInfos(in elf: ELF) -> SymbolInfos?

    func relocations(in elf: ELF) -> AnyRandomAccessCollection<Dynamic.Relocation>?

    var flags: DynamicFlags { get }
    var flags1: DynamicFlags1 { get }

    var numberOfVersionDefs: Int? { get }
    func _versionDef(in elf: ELF) -> Dynamic.VersionDef?
    func versionDefs(in elf: ELF) -> [Dynamic.VersionDef]

    var numberOfVersionNeeds: Int? { get }
    func _versionNeed(in elf: ELF) -> Dynamic.VersionNeed?
    func versionNeeds(in elf: ELF) -> [Dynamic.VersionNeed]

    func versionSyms(in elf: ELF) -> VersionSyms?
}
