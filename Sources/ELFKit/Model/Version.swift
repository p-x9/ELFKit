//
//  Version.swift
//
//
//  Created by p-x9 on 2023/11/29.
//
//

import Foundation

public struct Version: Sendable {
    public let major: Int
    public let minor: Int
    public let patch: Int
}

extension Version: CustomStringConvertible {
    public var description: String {
        "\(major).\(minor).\(patch)"
    }
}
