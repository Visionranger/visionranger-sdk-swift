//
//  APIEndpoint.swift
//  APIEndpoint
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class APIEndpoint: NSObject {
    
}


public enum VSNHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "PATCH"
    case delete = "DELETE"
}


public enum VSNAPIPath: String {
    case products = "/products"
    case configurations = "/configurations"
}
