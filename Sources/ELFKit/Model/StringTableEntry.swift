//
//  StringTableEntry.swift
//  
//
//  Created by p-x9 on 2024/04/27
//  
//

import Foundation

public struct StringTableEntry: Codable, Equatable {
    public let string: String
    ///  Offset from the beginning of the string table
    public let offset: Int
}
