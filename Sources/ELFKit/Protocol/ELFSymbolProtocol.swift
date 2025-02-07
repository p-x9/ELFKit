//
//  ELFSymbolProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public protocol ELFSymbolProtocol {
    var nameOffset: Int { get }

    var _commonBinding: SymbolBinding? { get }
    func binding(inELF header: ELFHeader) -> SymbolBinding?

    var _commonType: SymbolType? { get }
    func type(inELF header: ELFHeader) -> SymbolType?

    var visibility: SymbolVisibility! { get }
    var sectionIndex: Int? { get }

    var _commonSpecialSection: SpecialSectionIndex? { get }
    func specialSection(inELF header: ELFHeader) -> SpecialSectionIndex?

    func name(in elf: ELFFile, isDynamic: Bool) -> String?
    func demangledName(in elf: ELFFile, isDynamic: Bool) -> String?

    func name(in elf: ELFImage, isDynamic: Bool) -> String?
    func demangledName(in elf: ELFImage, isDynamic: Bool) -> String?
}

extension ELFSymbolProtocol {
    public func name(in elf: ELFFile, isDynamic: Bool) -> String? {
        var strings: ELFFile.Strings?
        if isDynamic {
            strings = elf.dynamicStringTable
        } else {
            strings = elf.stringTable
        }
        guard let strings else { return nil }
        return strings.string(at: nameOffset)?.string
    }

    public func name(in elf: ELFImage, isDynamic: Bool) -> String? {
        var strings: ELFImage.Strings?
        if isDynamic {
            strings = elf.dynamicStringTable
        } else {
            // FIXME: section is not available
            // strings = elf.stringTable
        }
        guard let strings else { return nil }
        return strings.string(at: nameOffset)?.string
    }
}

extension ELFSymbolProtocol {
    public func demangledName(in elf: ELFFile, isDynamic: Bool) -> String? {
        guard let name = name(in: elf, isDynamic: isDynamic) else {
            return nil
        }
        return stdlib_demangleName(name)
    }

    public func demangledName(in elf: ELFImage, isDynamic: Bool) -> String? {
        guard let name = name(in: elf, isDynamic: isDynamic) else {
            return nil
        }
        return stdlib_demangleName(name)
    }
}
