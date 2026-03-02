//
//  ELFRelrEntry.swift
//  ELFKit
//
//  Created by Codex on 2026/03/02.
//
//

import Foundation

/// Raw packed RELR entry decoded from `DT_RELR` / `SHT_RELR`.
public enum ELFRelrEntry: Sendable, Hashable {
    case address(UInt64)
    case bitmap(UInt64)

    public var rawValue: UInt64 {
        switch self {
        case let .address(value), let .bitmap(value):
            value
        }
    }
}
