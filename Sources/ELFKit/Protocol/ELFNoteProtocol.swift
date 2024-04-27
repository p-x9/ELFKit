//
//  ELFNoteProtocol.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

public protocol ELFNoteProtocol {
    associatedtype Header: ELFNoteHeaderProtocol

    var header: Header { get }
    var name: String? { get }
    var descriptionData: Data? { get }
}
