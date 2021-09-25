//
//  VSNDispatchFunctions.swift
//  VSNDispatchFunctions
//
//  Created by Colin Tessarzick on 25.09.21.
//

import Foundation

public func vsnDispatchToMainThreadIfNecessary(_ block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}
