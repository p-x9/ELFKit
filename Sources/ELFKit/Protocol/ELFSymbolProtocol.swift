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
    var sectionIndex: Int? { get }
    var specialSection: SpecialSectionIndex? { get }
}

extension ELFSymbolProtocol {
    public func name(in elf: ELFFile) -> String? {
        guard let strtab = elf._strtab,
              let data = strtab._strings(in: elf)?.data else {
            return nil
        }
        return String(cString: data.advanced(by: nameOffset))
    }
}
