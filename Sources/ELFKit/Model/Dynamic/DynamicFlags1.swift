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
    /// DF_1_TRANS
    public static let trans = DynamicFlags1(
        rawValue: Bit.trans.rawValue
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
    /// DF_1_KMOD
    public static let kmod = DynamicFlags1(
        rawValue: Bit.kmod.rawValue
    )
    /// DF_1_WEAKFILTER
    public static let weakfilter = DynamicFlags1(
        rawValue: Bit.weakfilter.rawValue
    )
    /// DF_1_NOCOMMON
    public static let nocommon = DynamicFlags1(
        rawValue: Bit.nocommon.rawValue
    )
}

extension DynamicFlags1 {
    public enum Bit: UInt32, CaseIterable {
        /// DF_1_NOW
        case now = 1
        /// DF_1_GLOBAL
        case global = 2
        /// DF_1_GROUP
        case group = 4
        /// DF_1_NODELETE
        case nodelete = 8
        /// DF_1_LOADFLTR
        case loadfltr = 0x10
        /// DF_1_INITFIRST
        case initfirst = 0x20
        /// DF_1_NOOPEN
        case noopen = 0x40
        /// DF_1_ORIGIN
        case origin = 0x80
        /// DF_1_DIRECT
        case direct = 0x100
        /// DF_1_TRANS
        case trans = 0x200
        /// DF_1_INTERPOSE
        case interpose = 0x400
        /// DF_1_NODEFLIB
        case nodeflib = 0x800
        /// DF_1_NODUMP
        case nodump = 0x1000
        /// DF_1_CONFALT
        case confalt = 0x2000
        /// DF_1_ENDFILTEE
        case endfiltee = 0x4000
        /// DF_1_DISPRELDNE
        case dispreldne = 0x8000
        /// DF_1_DISPRELPND
        case disprelpnd = 0x10000
        /// DF_1_NODIRECT
        case nodirect = 0x20000
        /// DF_1_IGNMULDEF
        case ignmuldef = 0x40000
        /// DF_1_NOKSYMS
        case noksyms = 0x80000
        /// DF_1_NOHDR
        case nohdr = 0x100000
        /// DF_1_EDITED
        case edited = 0x200000
        /// DF_1_NORELOC
        case noreloc = 0x400000
        /// DF_1_SYMINTPOSE
        case symintpose = 0x800000
        /// DF_1_GLOBAUDIT
        case globaudit = 0x1000000
        /// DF_1_SINGLETON
        case singleton = 0x2000000
        /// DF_1_STUB
        case stub = 0x4000000
        /// DF_1_PIE
        case pie = 0x8000000
        /// DF_1_KMOD
        case kmod = 0x10000000
        /// DF_1_WEAKFILTER
        case weakfilter = 0x20000000
        /// DF_1_NOCOMMON
        case nocommon = 0x40000000
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
        case .trans: "DF_1_TRANS"
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
        case .kmod: "DF_1_KMOD"
        case .weakfilter: "DF_1_WEAKFILTER"
        case .nocommon: "DF_1_NOCOMMON"
        }
    }
}
