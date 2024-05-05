//
//  ELFNoteProtocol.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

public protocol ELFNoteProtocol {
    associatedtype Header: ELFNoteHeaderProtocol & LayoutWrapper

    var header: Header { get }
    var name: String? { get }
    var descriptionData: Data? { get }

    init?(data: Data)
}

extension ELFNoteProtocol {
    var layoutSize: Int {
        header.layoutSize + header.nameSize + header.descriptionSize
    }

    var align: Int { 4 }

    var padding: Int {
        let reminder = layoutSize % align
        if reminder == 0 { return 0 }
        return align - reminder
    }
}

extension ELFNoteProtocol {
    public func gnuNoteContent(in elf: ELFFile) -> GnuNoteContent? {
        guard let name, name == "GNU",
              let descriptionData else {
            return nil
        }
        guard let type = GnuNoteType(rawValue: numericCast(header.type)) else {
            return nil
        }
        switch type {
        case .abi_tag:
            guard let abiTag = GnuABITag(data: descriptionData) else {
                return nil
            }
            return .abi_tag(abiTag)
        case .hwcap:
            guard let cap = GnuHardwareCapabilities(data: descriptionData) else {
                return nil
            }
            return .hwcap(cap)
        case .build_id:
            let id = descriptionData
                .map { $0 & 0xFF }
                .map { String(format: "%02x", $0) }
                .joined()
            return .build_id(id)
        case .gold_version:
            guard let version = String(cString: descriptionData) else {
                return nil
            }
            return .gold_version(version)
        case .property_type_0:
            return .property_type_0(descriptionData)
        }
    }
}
