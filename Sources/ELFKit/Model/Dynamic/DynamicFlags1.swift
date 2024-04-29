//
//  DynamicFlags1.swift
//
//
//  Created by p-x9 on 2024/04/30
//  
//

import Foundation
import ELFKitC

public struct DynamicFlags1: BitFlags {
    public typealias RawValue = UInt32

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension DynamicFlags1 {
    /// DF_1_NOW
    public static let now = DynamicFlags1(
        rawValue: Bit.now.rawValue
    )
    /// DF_1_GLOBAL
    public static let global = DynamicFlags1(
        rawValue: Bit.global.rawValue
    )
    /// DF_1_GROUP
    public static let group = DynamicFlags1(
        rawValue: Bit.group.rawValue
    )
    /// DF_1_NODELETE
    public static let nodelete = DynamicFlags1(
        rawValue: Bit.nodelete.rawValue
    )
    /// DF_1_LOADFLTR
    public static let loadfltr = DynamicFlags1(
        rawValue: Bit.loadfltr.rawValue
    )
    /// DF_1_INITFIRST
    public static let initfirst = DynamicFlags1(
        rawValue: Bit.initfirst.rawValue
    )
    /// DF_1_NOOPEN
    public static let noopen = DynamicFlags1(
        rawValue: Bit.noopen.rawValue
    )
    /// DF_1_ORIGIN
    public static let origin = DynamicFlags1(
        rawValue: Bit.origin.rawValue
    )
    /// DF_1_DIRECT
    public static let direct = DynamicFlags1(
        rawValue: Bit.direct.rawValue
    )
    /// DF_1_INTERPOSE
    public static let interpose = DynamicFlags1(
        rawValue: Bit.interpose.rawValue
    )
    /// DF_1_NODEFLIB
    public static let nodeflib = DynamicFlags1(
        rawValue: Bit.nodeflib.rawValue
    )
    /// DF_1_NODUMP
    public static let nodump = DynamicFlags1(
        rawValue: Bit.nodump.rawValue
    )
    /// DF_1_CONFALT
    public static let confalt = DynamicFlags1(
        rawValue: Bit.confalt.rawValue
    )
    /// DF_1_ENDFILTEE
    public static let endfiltee = DynamicFlags1(
        rawValue: Bit.endfiltee.rawValue
    )
    /// DF_1_DISPRELDNE
    public static let dispreldne = DynamicFlags1(
        rawValue: Bit.dispreldne.rawValue
    )
    /// DF_1_DISPRELPND
    public static let disprelpnd = DynamicFlags1(
        rawValue: Bit.disprelpnd.rawValue
    )
    /// DF_1_NODIRECT
    public static let nodirect = DynamicFlags1(
        rawValue: Bit.nodirect.rawValue
    )
    /// DF_1_IGNMULDEF
    public static let ignmuldef = DynamicFlags1(
        rawValue: Bit.ignmuldef.rawValue
    )
    /// DF_1_NOKSYMS
    public static let noksyms = DynamicFlags1(
        rawValue: Bit.noksyms.rawValue
    )
    /// DF_1_NOHDR
    public static let nohdr = DynamicFlags1(
        rawValue: Bit.nohdr.rawValue
    )
    /// DF_1_EDITED
    public static let edited = DynamicFlags1(
        rawValue: Bit.edited.rawValue
    )
    /// DF_1_NORELOC
    public static let noreloc = DynamicFlags1(
        rawValue: Bit.noreloc.rawValue
    )
    /// DF_1_SYMINTPOSE
    public static let symintpose = DynamicFlags1(
        rawValue: Bit.symintpose.rawValue
    )
    /// DF_1_GLOBAUDIT
    public static let globaudit = DynamicFlags1(
        rawValue: Bit.globaudit.rawValue
    )
    /// DF_1_SINGLETON
    public static let singleton = DynamicFlags1(
        rawValue: Bit.singleton.rawValue
    )
    /// DF_1_STUB
    public static let stub = DynamicFlags1(
        rawValue: Bit.stub.rawValue
    )
    /// DF_1_PIE
    public static let pie = DynamicFlags1(
        rawValue: Bit.pie.rawValue
    )
}

extension DynamicFlags1 {
    public enum Bit: CaseIterable {
        /// DF_1_NOW
        case now
        /// DF_1_GLOBAL
        case global
        /// DF_1_GROUP
        case group
        /// DF_1_NODELETE
        case nodelete
        /// DF_1_LOADFLTR
        case loadfltr
        /// DF_1_INITFIRST
        case initfirst
        /// DF_1_NOOPEN
        case noopen
        /// DF_1_ORIGIN
        case origin
        /// DF_1_DIRECT
        case direct
        /// DF_1_INTERPOSE
        case interpose
        /// DF_1_NODEFLIB
        case nodeflib
        /// DF_1_NODUMP
        case nodump
        /// DF_1_CONFALT
        case confalt
        /// DF_1_ENDFILTEE
        case endfiltee
        /// DF_1_DISPRELDNE
        case dispreldne
        /// DF_1_DISPRELPND
        case disprelpnd
        /// DF_1_NODIRECT
        case nodirect
        /// DF_1_IGNMULDEF
        case ignmuldef
        /// DF_1_NOKSYMS
        case noksyms
        /// DF_1_NOHDR
        case nohdr
        /// DF_1_EDITED
        case edited
        /// DF_1_NORELOC
        case noreloc
        /// DF_1_SYMINTPOSE
        case symintpose
        /// DF_1_GLOBAUDIT
        case globaudit
        /// DF_1_SINGLETON
        case singleton
        /// DF_1_STUB
        case stub
        /// DF_1_PIE
        case pie
    }
}

extension DynamicFlags1.Bit: RawRepresentable {
    public typealias RawValue = UInt32

    public init?(rawValue: RawValue) {
        switch rawValue {
        case RawValue(DF_1_NOW): self = .now
        case RawValue(DF_1_GLOBAL): self = .global
        case RawValue(DF_1_GROUP): self = .group
        case RawValue(DF_1_NODELETE): self = .nodelete
        case RawValue(DF_1_LOADFLTR): self = .loadfltr
        case RawValue(DF_1_INITFIRST): self = .initfirst
        case RawValue(DF_1_NOOPEN): self = .noopen
        case RawValue(DF_1_ORIGIN): self = .origin
        case RawValue(DF_1_DIRECT): self = .direct
        case RawValue(DF_1_INTERPOSE): self = .interpose
        case RawValue(DF_1_NODEFLIB): self = .nodeflib
        case RawValue(DF_1_NODUMP): self = .nodump
        case RawValue(DF_1_CONFALT): self = .confalt
        case RawValue(DF_1_ENDFILTEE): self = .endfiltee
        case RawValue(DF_1_DISPRELDNE): self = .dispreldne
        case RawValue(DF_1_DISPRELPND): self = .disprelpnd
        case RawValue(DF_1_NODIRECT): self = .nodirect
        case RawValue(DF_1_IGNMULDEF): self = .ignmuldef
        case RawValue(DF_1_NOKSYMS): self = .noksyms
        case RawValue(DF_1_NOHDR): self = .nohdr
        case RawValue(DF_1_EDITED): self = .edited
        case RawValue(DF_1_NORELOC): self = .noreloc
        case RawValue(DF_1_SYMINTPOSE): self = .symintpose
        case RawValue(DF_1_GLOBAUDIT): self = .globaudit
        case RawValue(DF_1_SINGLETON): self = .singleton
        case RawValue(DF_1_STUB): self = .stub
        case RawValue(DF_1_PIE): self = .pie
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .now: RawValue(DF_1_NOW)
        case .global: RawValue(DF_1_GLOBAL)
        case .group: RawValue(DF_1_GROUP)
        case .nodelete: RawValue(DF_1_NODELETE)
        case .loadfltr: RawValue(DF_1_LOADFLTR)
        case .initfirst: RawValue(DF_1_INITFIRST)
        case .noopen: RawValue(DF_1_NOOPEN)
        case .origin: RawValue(DF_1_ORIGIN)
        case .direct: RawValue(DF_1_DIRECT)
        case .interpose: RawValue(DF_1_INTERPOSE)
        case .nodeflib: RawValue(DF_1_NODEFLIB)
        case .nodump: RawValue(DF_1_NODUMP)
        case .confalt: RawValue(DF_1_CONFALT)
        case .endfiltee: RawValue(DF_1_ENDFILTEE)
        case .dispreldne: RawValue(DF_1_DISPRELDNE)
        case .disprelpnd: RawValue(DF_1_DISPRELPND)
        case .nodirect: RawValue(DF_1_NODIRECT)
        case .ignmuldef: RawValue(DF_1_IGNMULDEF)
        case .noksyms: RawValue(DF_1_NOKSYMS)
        case .nohdr: RawValue(DF_1_NOHDR)
        case .edited: RawValue(DF_1_EDITED)
        case .noreloc: RawValue(DF_1_NORELOC)
        case .symintpose: RawValue(DF_1_SYMINTPOSE)
        case .globaudit: RawValue(DF_1_GLOBAUDIT)
        case .singleton: RawValue(DF_1_SINGLETON)
        case .stub: RawValue(DF_1_STUB)
        case .pie: RawValue(DF_1_PIE)
        }
    }
}


extension DynamicFlags1.Bit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .now: "DF_1_NOW"
        case .global: "DF_1_GLOBAL"
        case .group: "DF_1_GROUP"
        case .nodelete: "DF_1_NODELETE"
        case .loadfltr: "DF_1_LOADFLTR"
        case .initfirst: "DF_1_INITFIRST"
        case .noopen: "DF_1_NOOPEN"
        case .origin: "DF_1_ORIGIN"
        case .direct: "DF_1_DIRECT"
        case .interpose: "DF_1_INTERPOSE"
        case .nodeflib: "DF_1_NODEFLIB"
        case .nodump: "DF_1_NODUMP"
        case .confalt: "DF_1_CONFALT"
        case .endfiltee: "DF_1_ENDFILTEE"
        case .dispreldne: "DF_1_DISPRELDNE"
        case .disprelpnd: "DF_1_DISPRELPND"
        case .nodirect: "DF_1_NODIRECT"
        case .ignmuldef: "DF_1_IGNMULDEF"
        case .noksyms: "DF_1_NOKSYMS"
        case .nohdr: "DF_1_NOHDR"
        case .edited: "DF_1_EDITED"
        case .noreloc: "DF_1_NORELOC"
        case .symintpose: "DF_1_SYMINTPOSE"
        case .globaudit: "DF_1_GLOBAUDIT"
        case .singleton: "DF_1_SINGLETON"
        case .stub: "DF_1_STUB"
        case .pie: "DF_1_PIE"
        }
    }
}
