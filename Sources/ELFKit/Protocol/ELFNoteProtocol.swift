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
        return layoutSize - reminder
    }
}
