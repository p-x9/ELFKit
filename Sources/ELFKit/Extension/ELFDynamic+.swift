//
//  ELFDynamic+.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

extension Sequence where Element: ELFDynamicProtocol {
    var _neededs: [Element] { filter { $0.tag == .needed } }

    var _strtab: Element? { first(where: { $0.tag == .strtab }) }
    var _strsiz: Element? { first(where: { $0.tag == .strsz }) }

    var _hash: Element? { first(where: { $0.tag == .hash }) }
    var _gnu_hash: Element? { first(where: { $0.tag == .gnu_hash }) }
    var _symtab: Element? { first(where: { $0.tag == .symtab }) }
    var _syment: Element? { first(where: { $0.tag == .syment }) }

    var _rela: Element? { first(where: { $0.tag == .rela }) }
    var _relasz: Element? { first(where: { $0.tag == .relasz }) }
    var _rel: Element? { first(where: { $0.tag == .rel }) }
    var _relsz: Element? { first(where: { $0.tag == .relsz }) }

    var _rpath: [Element] { filter { $0.tag == .rpath } }
    var _runpath: [Element] { filter { $0.tag == .runpath } }
}

extension Sequence where Element: ELFDynamicProtocol {
    // same as `.dynstr` section
    public func strings(in elf: ELFFile) -> ELFFile.Strings? {
        guard let _strtab, let _strsiz else {
            return nil
        }
        let offset = _strtab.pointer
        let size = _strsiz.value
        return .init(elf: elf, offset: offset, size: size)
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func neededs(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _neededs.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func rpaths(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _rpath.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }

    public func runpaths(in elf: ELFFile) -> [String] {
        guard let strings = strings(in: elf) else { return [] }
        return _runpath.compactMap {
            strings.string(at: numericCast($0.value))?.string
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func hashTableHeader32(in elf: ELFFile) -> ELF32HashTableHeader? {
        guard let _hash else { return nil }
        guard !elf.is64Bit else { return nil }
        return elf.fileHandle.read(
            offset: numericCast(_hash.pointer)
        )
    }

    public func hashTableHeader64(in elf: ELFFile) -> ELF64HashTableHeader? {
        guard let _hash else { return nil }
        guard elf.is64Bit else { return nil }
        return elf.fileHandle.read(
            offset: numericCast(_hash.pointer)
        )
    }

    public func hashTableHeader(in elf: ELFFile) -> (any ELFHashTableHeaderProtocol)? {
        if elf.is64Bit {
            return hashTableHeader64(in: elf)
        } else {
            return hashTableHeader32(in: elf)
        }
    }

    public func hashTable32(in elf: ELFFile) -> ELF32HashTable? {
        guard let _hash else { return nil }
        guard let header = hashTableHeader32(in: elf) else {
            return nil
        }

        let bucketStart: Int = numericCast(_hash.pointer) + numericCast(header.layoutSize)
        let buckets: DataSequence<Elf32_Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(bucketStart),
            numberOfElements: numericCast(header.nbuckets)
        )

        let chainStart: Int = bucketStart + buckets.data.count
        let chains: DataSequence<Elf32_Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(chainStart),
            numberOfElements: numericCast(header.nchain)
        )
        return .init(
            header: header,
            buckets: Array(buckets),
            chains: Array(chains)
        )
    }

    public func hashTable64(in elf: ELFFile) -> ELF64HashTable? {
        guard let _hash else { return nil }
        guard let header = hashTableHeader64(in: elf) else {
            return nil
        }

        let bucketStart: Int = numericCast(_hash.pointer) + numericCast(header.layoutSize)
        let buckets: DataSequence<Elf64_Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(bucketStart),
            numberOfElements: numericCast(header.nbuckets)
        )

        let chainStart: Int = bucketStart + buckets.data.count
        let chains: DataSequence<Elf64_Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(chainStart),
            numberOfElements: numericCast(header.nchain)
        )
        return .init(
            header: header,
            buckets: Array(buckets),
            chains: Array(chains)
        )
    }

    public func hashTable(in elf: ELFFile) -> (any ELFHashTableProtocol)? {
        if elf.is64Bit {
            return hashTable64(in: elf)
        } else {
            return hashTable32(in: elf)
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func gnuHashTableHeader(in elf: ELFFile) -> ELFGnuHashTableHeader? {
        guard let _gnu_hash else { return nil }
        return elf.fileHandle.read(
            offset: numericCast(_gnu_hash.pointer)
        )
    }

    public func gnuHashTable32(in elf: ELFFile) -> ELF32GnuHashTable? {
        guard !elf.is64Bit, let _gnu_hash else { return nil }
        guard let header = gnuHashTableHeader(in: elf) else {
            return nil
        }

        let bloomsStart: Int = numericCast(_gnu_hash.pointer) + numericCast(header.layoutSize)
        let blooms: DataSequence<ELF32GnuHashTable.Bloom> = elf.fileHandle.readDataSequence(
            offset: numericCast(bloomsStart),
            numberOfElements: numericCast(header.gh_maskwords)
        )

        let bucketsStart: Int = bloomsStart + blooms.data.count
        let buckets: DataSequence<ELF32GnuHashTable.Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(bucketsStart),
            numberOfElements: numericCast(header.gh_nbuckets)
        )

        let chainsOffset = bucketsStart + buckets.data.count

        return .init(
            header: header,
            bloom: Array(blooms),
            buckets: Array(buckets),
            chainsOffset: chainsOffset
        )
    }

    public func gnuHashTable64(in elf: ELFFile) -> ELF64GnuHashTable? {
        guard elf.is64Bit, let _gnu_hash else { return nil }
        guard let header = gnuHashTableHeader(in: elf) else {
            return nil
        }

        let bloomsStart: Int = numericCast(_gnu_hash.pointer) + numericCast(header.layoutSize)
        let blooms: DataSequence<ELF64GnuHashTable.Bloom> = elf.fileHandle.readDataSequence(
            offset: numericCast(bloomsStart),
            numberOfElements: numericCast(header.gh_maskwords)
        )

        let bucketsStart: Int = bloomsStart + blooms.data.count
        let buckets: DataSequence<ELF64GnuHashTable.Hashelt> = elf.fileHandle.readDataSequence(
            offset: numericCast(bucketsStart),
            numberOfElements: numericCast(header.gh_nbuckets)
        )

        let chainsOffset = bucketsStart + buckets.data.count

        return .init(
            header: header,
            bloom: Array(blooms),
            buckets: Array(buckets),
            chainsOffset: chainsOffset
        )
    }

    public func gnuHashTable(in elf: ELFFile) -> (any ELFGnuHashTableProtocol)? {
        if elf.is64Bit {
            return gnuHashTable64(in: elf)
        } else {
            return gnuHashTable32(in: elf)
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func symbols32(in elf: ELFFile) -> DataSequence<ELF32Symbol>? {
        guard !elf.is64Bit, let _symtab else { return nil }
        var numberOfSymbols: Int?
        if let hashHeader = hashTableHeader(in: elf) {
            numberOfSymbols = hashHeader.numberOfChains
        } else if let gnuHashTable = gnuHashTable(in: elf) {
            numberOfSymbols = gnuHashTable.numberOfSymbols(in: elf)
        }
        guard let numberOfSymbols else { return nil }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_symtab.pointer),
            numberOfElements: numberOfSymbols
        )
    }

    public func symbols64(in elf: ELFFile) -> DataSequence<ELF64Symbol>? {
        guard elf.is64Bit, let _symtab else { return nil }
        var numberOfSymbols: Int?
        if let hashHeader = hashTableHeader(in: elf) {
            numberOfSymbols = hashHeader.numberOfChains
        } else if let gnuHashTable = gnuHashTable(in: elf) {
            numberOfSymbols = gnuHashTable.numberOfSymbols(in: elf)
        }
        guard let numberOfSymbols else { return nil }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_symtab.pointer),
            numberOfElements: numberOfSymbols
        )
    }

    public func symbols(in elf: ELFFile) -> [ELFSymbolProtocol]? {
        if elf.is64Bit {
            return symbols64(in: elf)?.map { $0 }
        } else {
            return symbols32(in: elf)?.map { $0 }
        }
    }
}
