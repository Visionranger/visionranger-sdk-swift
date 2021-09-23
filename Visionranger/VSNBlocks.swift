//
//  VSNBlocks.swift
//  VSNBlocks
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public typealias VSNVoidBlock = () -> Void

public typealias VSNErrorBlock = (Error?) -> Void

public typealias VSNBooleanSuccessBlock = (Bool?, Error?) -> Void

public typealias VSNJSONResponseCompletionBlock = (String?, Error?) -> Void

public typealias VSNProductCompletionBlock = (VSNProduct?, Error?) -> Void

public typealias VSNProductsCompletionBlock = ([VSNProduct]?, Error?) -> Void
