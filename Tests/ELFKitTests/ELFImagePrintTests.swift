//
//  ELFImagePrintTests.swift
//  ELFKit
//
//  Created by p-x9 on 2025/02/08
//  
//

import XCTest
@testable import ELFKit

#if os(Linux)

final class ELFImagePrintTests: XCTestCase {
    private var elf: ELFImage!

    override func setUp() {
        self.elf = ELFImage(name: "libc")
    }
}

extension ELFImagePrintTests {
    func testHeader() {
        let header = elf.header
        let identifier = header.identifier!

        print("Class:", identifier.class ?? .none)
        print("Data Type:", identifier.data ?? .none)
        print("Version:", identifier.version)
        print("OS ABI:", header.osABI ?? .none)
        print("ABI Version:", identifier.abiVersion)

        print("Type:", header.type ?? .none)
        print("Machine:", header.machine ?? .none)
    }

    func testPrograms() {
        for (i, program) in elf.programs.enumerated() {
            print("----")
            print("[\(i)]")
            let type = program.type(inELF: elf.header)
            print("Type:", type ?? "Unknown")
            print("Flags:", program.flags(inELF: elf.header).bits)
            print("Offset:", program.offset)
            print("FileSize:", program.fileSize)
        }
    }

    func testDynamics() {
        guard let dynamics = elf.dynamics else { return }
        for (i, dynamic) in dynamics.enumerated() {
            print("----")
            print("[\(i)]")
            let tag = dynamic.tag(inELF: elf.header)
            print("Tag:", tag?.description ?? "Unknown")
            print("Value/Pointer:", dynamic.value)
        }
    }

    func testDynamicSymbols() {
        let symbols = elf.dynamicSymbols
        for (i, symbol) in symbols.enumerated() {
            print("----")
            print(
                "[\(i)] Name:",
                symbol.name(in: elf, isDynamic: true) ?? "Unknown"
            )
            print(
                "Binding:",
                symbol.binding(inELF: elf.header)?.description ?? "Unknown"
            )
            print(
                "Type:",
                symbol.type(inELF: elf.header)?.description ?? "Unknown"
            )
            print("Visibility:", symbol.visibility!)
            if let specialSection = symbol.specialSection(inELF: elf.header) {
                print("Special:", specialSection)
            } else if let sectionIndex = symbol.sectionIndex {
                print("SectionIndex:", sectionIndex)
            }
        }
    }

    func testRelocations() {
        guard let dynamics = elf.dynamics64 else { return }
        guard let relocations = dynamics.relocations(in: elf) else { return }

        let symbols = Array(elf.dynamicSymbols)
        for (i, relocation) in relocations.enumerated() {
            print(" ----")
            print(" [\(i)]")
            print(" Offset:", String(relocation.offset, radix: 16))
            print(" SymbolIndex:", relocation.symbolIndex)
            print(
                " Symbol:",
                symbols[relocation.symbolIndex]
                    .name(in: elf, isDynamic: true) ?? ""
            )
            print(" Type:", relocation._type)
            print(" Addend:", relocation.addend)
        }
    }
}

// MARK: - Dynamics
extension ELFImagePrintTests {
    func testNeeds() {
        print("Shared Library:")
        for (i, need) in elf.dependencies.enumerated() {
            print(" [\(i)]", need)
        }
    }

    func testRunPaths() {
        print("Run Paths:")
        for (i, path) in elf.rpaths.enumerated() {
            print(" [\(i)]", path)
        }
    }
}

// MARK: - Dynamics
extension ELFImagePrintTests {
    func testSOName() {
        guard let dynamics = elf.dynamics64 else { return }
        let soname = dynamics.sharedObjectName(in: elf)
        print("SO Name:", soname ?? "Unknown")
    }

    func testDynamicFlags() {
        guard let dynamics = elf.dynamics64 else { return }
        print(
            "Flags:",
            dynamics.flags.bits
        )
        print(
            "Flags1:",
            dynamics.flags1.bits
        )
    }

    func testVersionDef() {
        guard let dynamics = elf.dynamics64 else { return }
        let versionDefs = dynamics.versionDefs(in: elf)
        for versionDef in versionDefs {
            print("----")
            print("Number of Aux:", versionDef.numberOfAux)
            print("Index:", versionDef.versionIndex)
            print("Flags:", versionDef.flags.bits)

            let auxes = versionDef.auxes(in: elf)
            for aux in auxes {
                print(
                    " Name:",
                    aux.name(in: elf) ?? "Unknown"
                )
            }
        }
    }

    func testVersionNeed() {
        guard let dynamics = elf.dynamics64 else { return }
        let versionNeeds = dynamics.versionNeeds(in: elf)
        for versionNeed in versionNeeds {
            print("----")
            print("Number of Aux:", versionNeed.numberOfAux)
            print(
                "File:",
                versionNeed.fileName(in: elf) ?? "Unknown"
            )

            let auxes = versionNeed.auxes(in: elf)
            for aux in auxes {
                print(
                    " Name:",
                    aux.name(in: elf) ?? "Unknown",
                    terminator: ", "
                )
                print("Flags:", aux.flags.bits, terminator: ", ")
                print(
                    " Version:",
                    aux.version
                )
            }
        }
    }

    func testVersionSyms() {
        guard let dynamics = elf.dynamics64 else { return }

        guard let versyms = dynamics.versionSyms(in: elf) else {
            return
        }

        let symbols = Array(elf.dynamicSymbols)

        let defAuxes = dynamics.versionDefs(in: elf)
            .map { $0.auxes(in: elf) }
            .flatMap { $0 }
        let needAuxed = dynamics.versionNeeds(in: elf)
            .map { $0.auxes(in: elf) }
            .flatMap { $0 }

        for (versym, symbol) in zip(versyms, symbols) {
            print("----")
            print(
                "Name:",
                symbol.name(in: elf, isDynamic: true) ?? "Unknown"
            )
            if versym.version == 0 {
                print("(*local*)")
            } else if versym.version == 1 {
                print("(*global*)")
            } else if versym.version <= defAuxes.count {
                let def = defAuxes[versym.version - 1]
                print(" \(def.name(in: elf) ?? "Unknown")")
            } else if let need = needAuxed.first(where: { $0.version == versym.version }) {
                print(" \(need.name(in: elf) ?? "Unknown")")
            } else {
                print(" \(versym.version)")
            }
        }
    }
}

// MARK: - Note
extension ELFImagePrintTests {
    func testNotes() {
        let programs = elf.programs64!.filter({
            $0.type(inELF: elf.header) == .note
        })

        for program in programs {
            guard let notes = program._notes(in: elf) else {
                continue
            }
            for note in notes {
                print("----")
                print("Name:", note.name ?? "Unknown")
                print("Type:", note.header.type)
                print("Size:", note.header.descriptionSize)
            }
        }
    }

    func testGnuABITag() {
        // https://github.com/crossbridge-community/crossbridge/blob/78312c50dbcb3463e2e05b2763a595d4e6ec51c4/binutils/binutils/readelf.c#L12273
        let note = elf.programs
            .compactMap { $0._notes(in: elf) }
            .flatMap { $0 }
            .compactMap { $0.gnuNoteContent }
            .first(where: { $0.type == .abi_tag })
        guard let note,
              case let .abi_tag(abiTag) = note else {
            return
        }
        print("OS:", abiTag.os!, "ABI:", abiTag.version)
    }

    func testGnuBuildID() {
        let note = elf.programs
            .compactMap { $0._notes(in: elf) }
            .flatMap { $0 }
            .compactMap { $0.gnuNoteContent}
            .first(where: { $0.type == .build_id })
        guard let note,
              case let .build_id(id) = note else {
            return
        }
        print("BuildID:", id)
    }

    func testGnuGoldVersion() {
        let note = elf.programs
            .compactMap { $0._notes(in: elf) }
            .flatMap { $0 }
            .compactMap { $0.gnuNoteContent }
            .first(where: { $0.type == .gold_version })
        guard let note,
              case let .gold_version(id) = note else {
            return
        }
        print("Version:", id)
    }
}

// MARK: - Hash
extension ELFImagePrintTests {
    func testHashTable() {
        guard let dynamics = elf.dynamics64,
              let hashTable = dynamics.hashTable(in: elf) else {
            return
        }
        let header = hashTable.header
        print(header.layout)
    }

    func testGnuHashTable() {
        guard let dynamics = elf.dynamics64,
              let hashTable = dynamics.gnuHashTable(in: elf) else {
            return
        }
        let header = hashTable.header
        print(header.layout)
    }

    func testFindSymbolWithHashTable() {
        let symbolName = "__libc_scratch_buffer_grow_preserve"
        guard let dynamics = elf.dynamics64,
              let hashTable = dynamics.hashTable(in: elf) else {
            return
        }
        if let symbol = hashTable.findSymbol(
            named: symbolName,
            in: elf
        ) {
            print(
                "Found:",
                symbol.name(in: elf, isDynamic: true) ?? "Unknown"
            )
        } else {
            print("Not Found")
        }
    }

    func testFindSymbolWithGnuHashTable() {
        let symbolName = "__libc_scratch_buffer_grow_preserve"
        guard let dynamics = elf.dynamics64,
              let hashTable = dynamics.gnuHashTable(in: elf) else {
            return
        }
        if let symbol = hashTable.findSymbol(
            named: symbolName,
            in: elf
        ) {
            print(
                "Found:",
                symbol.name(in: elf, isDynamic: true) ?? "Unknown"
            )
        } else {
            print("Not Found")
        }
    }
}

#endif
