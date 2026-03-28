//
//  ArchiveFileTests.swift
//  ELFKit
//
//  Created by p-x9 on 2026/03/28
//  
//

import Foundation
import XCTest
@testable import ELFKit
import ObjectArchiveKit
import ELFArchiveKit

final class ArchiveFileTests: XCTestCase {
    var archive: ArchiveFile!

    override func setUp() async throws {
        let path = ""
        let url = URL(fileURLWithPath: path)
        self.archive = try ArchiveFile(url: url)
    }

    func testDumpFileStructure() throws {
        func dump(_ elf: ELFFile, name: String, level: Int) {
            print(String(repeating: " ", count: level) + name)
        }

        func dump(_ archive: ArchiveFile, level: Int) {
            print(String(repeating: " ", count: level) + "Archive")
            do {
                let elfs = try archive.elfFiles()
                for elf in elfs {
                    dump(elf, name: elf.name, level: level + 1)
                }
            } catch {}
        }
        dump(archive, level: 0)
    }
}

extension ArchiveFileTests {
    func testGNUSymbols() throws {
        guard let symbolTable = archive.gnuSymbolTable else {
            return
        }
        print("count: \(symbolTable.count)")
        if let offsets = symbolTable.offsets(in: archive) {
            print("offset:")
            for (i, offset) in offsets.enumerated() {
                print("", i, offset)
            }
        }
        if let names = try symbolTable.names(in: archive) {
            print("names:")
            for (i, name) in names.enumerated() {
                print("", i, name.string)
            }
        }
    }

    func testGNUStrings() {
        guard let strings = archive.gnuStrings else {
            return
        }
        for string in strings {
            print(string.offset, string.string)
        }
    }
}

extension ArchiveFileTests {
    func testBSDSymbols() throws {
        guard let symbolTable = archive.bsdSymbolTable else {
            return
        }
        print("count: \(symbolTable.count)")
        print("isSorted: \(symbolTable.isSorted(in: archive))")
        for symbol in try symbolTable.entries(in: archive) {
            let name = try symbolTable.name(for: symbol, in: archive)
            print(name ?? "unknown", symbol.stringOffset, symbol.headerOffset)
        }
    }
}
