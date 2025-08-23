//
//  ELFNoteHeaderProtocol.swift
//
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation
import ELFKitC

public protocol ELFNoteHeaderProtocol: Sendable {
    var nameSize: Int { get }
    var descriptionSize: Int { get }
    var type: Int { get }
}
