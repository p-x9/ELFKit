//
//  Linux.swift
//
//
//  Created by p-x9 on 2024/05/12
//  
//

import Foundation

#if os(Linux)
func autoreleasepool<T>(block: () -> T) -> T { block() }
#endif
