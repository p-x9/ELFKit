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
    var _soname: Element? { first(where: { $0.tag == .soname }) }

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

    var _flags: Element? { first(where: { $0.tag == .flags }) }
    var _flags_1: Element? { first(where: { $0.tag == .flags_1 }) }

    var _syminfo: Element? { first(where: { $0.tag == .syminfo }) }
    var _syminsz: Element? { first(where: { $0.tag == .syminsz }) }

    var _verdef: Element? { first(where: { $0.tag == .verdef }) }
    var _verdefnum: Element? { first(where: { $0.tag == .verdefnum }) }

    var _verneed: Element? { first(where: { $0.tag == .verneed }) }
    var _verneednum: Element? { first(where: { $0.tag == .verneednum }) }

    var _versym: Element? { first(where: { $0.tag == .versym }) }
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
    public func sharedObjectName(in elf: ELFFile) -> String? {
        guard let _soname else { return nil }
        guard let strings = strings(in: elf) else { return nil }
        return strings.string(at: _soname.value)?.string
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
    public func numberOfSymbols(in elf: ELFFile) -> Int? {
        if let hashHeader = hashTableHeader(in: elf) {
            return hashHeader.numberOfChains
        } else if let gnuHashTable = gnuHashTable(in: elf) {
            return gnuHashTable.numberOfSymbols(in: elf)
        }
        return nil
    }

    public func symbols32(in elf: ELFFile) -> DataSequence<ELF32Symbol>? {
        guard !elf.is64Bit, let _symtab else { return nil }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_symtab.pointer),
            numberOfElements: numberOfSymbols
        )
    }

    public func symbols64(in elf: ELFFile) -> DataSequence<ELF64Symbol>? {
        guard elf.is64Bit, let _symtab else { return nil }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
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

extension Sequence where Element: ELFDynamicProtocol {
    public func relocations32(in elf: ELFFile) -> AnyRandomAccessCollection<ELF32Relocation>? {
        guard !elf.is64Bit else { return nil }
        if let _rel, let _relsz {
            let count = _relsz.value / ELF32RelocationInfo.layoutSize
            let sequence: DataSequence<ELF32RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rel.pointer),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let _relasz {
            let count = _relasz.value / ELF32RelocationAddendInfo.layoutSize
            let sequence: DataSequence<ELF32RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rela.pointer),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        }
        return nil
    }

    public func relocations64(in elf: ELFFile) -> AnyRandomAccessCollection<ELF64Relocation>? {
        guard elf.is64Bit else { return nil }
        if let _rel, let _relsz {
            let count = _relsz.value / ELF64RelocationInfo.layoutSize
            let sequence: DataSequence<ELF64RelocationInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rel.pointer),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .general($0) }
            )
        }

        if let _rela, let _relasz {
            let count = _relasz.value / ELF64RelocationAddendInfo.layoutSize
            let sequence: DataSequence<ELF64RelocationAddendInfo> = elf.fileHandle.readDataSequence(
                offset: numericCast(_rela.pointer),
                numberOfElements: count
            )
            return AnyRandomAccessCollection(
                sequence.map { .addend($0) }
            )
        }
        return nil
    }

    public func relocations(in elf: ELFFile) -> [any ELFRelocationProtocol]? {
        if elf.is64Bit {
            return relocations64(in: elf)?.map { $0 }
        } else {
            return relocations32(in: elf)?.map { $0 }
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public var flags: DynamicFlags {
        guard let _flags else {
            return .init(rawValue: 0)
        }
        return .init(rawValue: numericCast(_flags.value))
    }

    public var flags1: DynamicFlags1 {
        guard let _flags_1 else {
            return .init(rawValue: 0)
        }
        return .init(rawValue: numericCast(_flags_1.value))
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func symbolInfos32(in elf: ELFFile) -> DataSequence<ELF32SymbolInfo>? {
        guard !elf.is64Bit else { return nil }
        guard let _syminfo, let _syminsz else { return nil }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_syminfo.pointer),
            numberOfElements: numericCast(_syminsz.value) / ELF32SymbolInfo.layoutSize
        )
    }

    public func symbolInfos64(in elf: ELFFile) -> DataSequence<ELF64SymbolInfo>? {
        guard elf.is64Bit else { return nil }
        guard let _syminfo, let _syminsz else { return nil }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_syminfo.pointer),
            numberOfElements: numericCast(_syminsz.value) / ELF64SymbolInfo.layoutSize
        )
    }

    public func symbolInfos(in elf: ELFFile) -> [any ELFSymbolInfoProtocol]? {
        if elf.is64Bit {
            return symbolInfos64(in: elf)?.map { $0 }
        } else {
            return symbolInfos32(in: elf)?.map { $0 }
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public var numberOfVersionDefs: Int? {
        guard let _verdefnum else { return nil }
        return numericCast(_verdefnum.value)
    }

    public func _versionDef64(in elf: ELFFile) -> ELF64VersionDef? {
        guard elf.is64Bit,
              let _verdef else {
            return nil
        }
        let layout: ELF64VersionDef.Layout = elf.fileHandle.read(
            offset: numericCast(_verdef.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verdef.pointer)
        )
    }

    public func _versionDef32(in elf: ELFFile) -> ELF32VersionDef? {
        guard !elf.is64Bit,
              let _verdef else {
            return nil
        }
        let layout: ELF32VersionDef.Layout = elf.fileHandle.read(
            offset: numericCast(_verdef.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verdef.pointer)
        )
    }

    public func _versionDef(in elf: ELFFile) -> (any ELFVersionDefProtocol)? {
        if elf.is64Bit {
            return _versionDef64(in: elf)
        } else {
            return _versionDef32(in: elf)
        }
    }

    public func versionDefs64(in elf: ELFFile) -> [ELF64VersionDef] {
        var def = _versionDef64(in: elf)
        var defs: [ELF64VersionDef] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }

    public func versionDefs32(in elf: ELFFile) -> [ELF32VersionDef] {
        var def = _versionDef32(in: elf)
        var defs: [ELF32VersionDef] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }

    public func versionDefs(in elf: ELFFile) -> [any ELFVersionDefProtocol] {
        if elf.is64Bit {
            return versionDefs64(in: elf)
        } else {
            return versionDefs32(in: elf)
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public var numberOfVersionNeeds: Int? {
        guard let _verneednum else { return nil }
        return numericCast(_verneednum.value)
    }

    public func _versionNeed64(in elf: ELFFile) -> ELF64VersionNeed? {
        guard elf.is64Bit,
              let _verneed else {
            return nil
        }
        let layout: ELF64VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(_verneed.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verneed.pointer)
        )
    }

    public func _versionNeed32(in elf: ELFFile) -> ELF32VersionNeed? {
        guard !elf.is64Bit,
              let _verneed else {
            return nil
        }
        let layout: ELF32VersionNeed.Layout = elf.fileHandle.read(
            offset: numericCast(_verneed.pointer)
        )
        return .init(
            layout: layout,
            _index: 0,
            _offset: numericCast(_verneed.pointer)
        )
    }

    public func _versionNeed(in elf: ELFFile) -> (any ELFVersionNeedProtocol)? {
        if elf.is64Bit {
            return _versionNeed64(in: elf)
        } else {
            return _versionNeed32(in: elf)
        }
    }

    public func versionNeeds64(in elf: ELFFile) -> [ELF64VersionNeed] {
        var def = _versionNeed64(in: elf)
        var defs: [ELF64VersionNeed] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }

    public func versionNeeds32(in elf: ELFFile) -> [ELF32VersionNeed] {
        var def = _versionNeed32(in: elf)
        var defs: [ELF32VersionNeed] = []
        while def != nil {
            guard let _def = def else { break }
            defs.append(_def)
            def = _def._next(in: elf)
        }
        return defs
    }

    public func versionNeeds(in elf: ELFFile) -> [any ELFVersionNeedProtocol] {
        if elf.is64Bit {
            return versionNeeds64(in: elf)
        } else {
            return versionNeeds32(in: elf)
        }
    }
}

extension Sequence where Element: ELFDynamicProtocol {
    public func versionSyms64(in elf: ELFFile) -> DataSequence<ELF64VersionSym>? {
        guard elf.is64Bit,
              let _versym else {
            return nil
        }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_versym.pointer),
            numberOfElements: numberOfSymbols
        )
    }

    public func versionSyms32(in elf: ELFFile) -> DataSequence<ELF32VersionSym>? {
        guard !elf.is64Bit,
              let _versym else {
            return nil
        }
        guard let numberOfSymbols = numberOfSymbols(in: elf) else {
            return nil
        }
        return elf.fileHandle.readDataSequence(
            offset: numericCast(_versym.pointer),
            numberOfElements: numberOfSymbols
        )
    }

    public func versionSyms(in elf: ELFFile) -> [any ELFVersionSymProtocol]? {
        if elf.is64Bit {
            return versionSyms64(in: elf)?.map { $0 }
        } else {
            return versionSyms32(in: elf)?.map { $0 }
        }
    }
}
