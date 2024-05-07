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
    var binding: SymbolBinding! { get }
    var type: SymbolType! { get }
    var visibility: SymbolVisibility! { get }
    var sectionIndex: Int? { get }
    var specialSection: SpecialSectionIndex? { get }
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
}

extension ELFSymbolProtocol {
    public func demangledName(in elf: ELFFile, isDynamic: Bool) -> String? {
        guard let name = name(in: elf, isDynamic: isDynamic) else {
            return nil
        }
        return stdlib_demangleName(name)
    }
}
