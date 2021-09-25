//
//  VSNAPIResponseDecodable.swift
//  VSNAPIResponseDecodable
//
//  Created by Colin Tessarzick on 23.09.21.
//

import Foundation

@objc public protocol VSNAPIResponseDecodable: NSObjectProtocol {
    
    static func decodedObject(fromAPIResponse response: [AnyHashable: Any]?) -> Self?
    
    var allResponseFields: [AnyHashable: Any] { get }
}
