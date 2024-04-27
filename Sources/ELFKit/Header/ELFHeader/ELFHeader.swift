//
//  ELFHeader.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation

public enum ELFHeader {
    case _32(ELF32Header)
    case _64(ELF64Header)
}

extension ELFHeader {
    public var identifier: HeaderIdentifier! {
        switch self {
        case ._32(let v): v.identifier
        case ._64(let v): v.identifier
        }
    }

    public var type: ELFType! {
        switch self {
        case ._32(let v): v.type
        case ._64(let v): v.type
        }
    }

    public var machine: ELFMachine! {
        switch self {
        case ._32(let v): v.machine
        case ._64(let v): v.machine
        }
    }
}

extension ELFHeader {
    public var sectionTableOffset: Int {
        switch self {
        case ._32(let v): numericCast(v.e_shoff)
        case ._64(let v): numericCast(v.e_shoff)
        }
    }

    public var sectionTableEntrySize: Int {
        switch self {
        case ._32(let v): numericCast(v.e_shentsize)
        case ._64(let v): numericCast(v.e_shentsize)
        }
    }

    public var numberOfSections: Int {
        switch self {
        case ._32(let v): numericCast(v.e_shnum)
        case ._64(let v): numericCast(v.e_shnum)
        }
    }

    public var sectionNameStringTableIndex: Int {
        switch self {
        case ._32(let v): numericCast(v.e_shstrndx)
        case ._64(let v): numericCast(v.e_shstrndx)
        }
    }
}

extension ELFHeader {
    public var programTableOffset: Int {
        switch self {
        case ._32(let v): numericCast(v.e_phoff)
        case ._64(let v): numericCast(v.e_phoff)
        }
    }

    public var programTableEntrySize: Int {
        switch self {
        case ._32(let v): numericCast(v.e_phentsize)
        case ._64(let v): numericCast(v.e_phentsize)
        }
    }

    public var numberOfPrograms: Int {
        switch self {
        case ._32(let v): numericCast(v.e_phnum)
        case ._64(let v): numericCast(v.e_phnum)
        }
    }
}
