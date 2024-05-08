//
//  HeaderIdentifier.swift
//
//
//  Created by p-x9 on 2024/04/26
//  
//

import Foundation
import ELFKitC

public struct HeaderIdentifier: LayoutWrapper {
    public typealias Layout = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    public var layout: Layout

    init?(layout: Layout) {
        guard layout.0 == ELFMAG0, /* EI_MAG0 */
              layout.1 == UInt8(ascii: "E") /* EI_MAG1 */,
              layout.2 == UInt8(ascii: "L") /* EI_MAG2 */,
              layout.3 == UInt8(ascii: "F") /* EI_MAG3 */ else {
            return nil
        }
        self.layout = layout
    }
}

extension HeaderIdentifier {
    public var `class`: ELFClass! {
        .init(rawValue: layout.4) /* EI_CLASS */
    }

    public var data: ELFData! {
        .init(rawValue: layout.5) /* EI_DATA */
    }

    public var version: UInt8 {
        layout.6 /* EI_VERSION */
    }

    /* OSABI */
    // EI_OSABI
    // Not defined here because OSABI needs to take into account the value of the `machine` in the header.

    public var abiVersion: UInt8 {
        layout.8 // EI_ABIVERSION
    }
}
