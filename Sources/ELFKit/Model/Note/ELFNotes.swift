//
//  ELFNotes.swift
//
//
//  Created by p-x9 on 2024/04/28
//  
//

import Foundation

public typealias ELF32Notes = _ELFNotes<ELF32Note>
public typealias ELF64Notes = _ELFNotes<ELF64Note>

public struct _ELFNotes<Note: ELFNoteProtocol>: Sequence {
    let data: Data

    public func makeIterator() -> Iterator {
        .init(data: data)
    }
}

extension _ELFNotes {
    public struct Iterator: IteratorProtocol {
        public typealias Element = Note

        private let data: Data
        private var nextOffset: Int = 0

        init(data: Data) {
            self.data = data
        }

        public mutating func next() -> Element? {
            guard nextOffset < data.count else { return nil }

            let note = Note(
                data: data.advanced(by: nextOffset)
            )

            if let note {
                nextOffset += note.layoutSize + note.padding
            }

            return note
        }
    }
}
