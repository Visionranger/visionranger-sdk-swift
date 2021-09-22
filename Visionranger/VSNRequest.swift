//
//  VSNRequest.swift
//  VSNRequest
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VSNRequest: NSObject, VSNRequestDelegate {
    
    public var body: Data?
    
    public var query: [URLQueryItem]?
    
    public var path: VSNAPIPath
    
    public var method: VSNHTTPMethod
    
    public var session: URLSession
    
    public init(method: VSNHTTPMethod, path: VSNAPIPath, session: URLSession) {
        self.method = method
        self.path = path
        self.session = session
    }
}

public protocol VSNRequestDelegate {
    var host: String { get }
    var path: VSNAPIPath { get }
    var method: VSNHTTPMethod { get }
    var session: URLSession { get }
    var body: Data? { get }
    var query: [URLQueryItem]? { get }
}

public extension VSNRequestDelegate {
    
    var host: String {
        return "https://k9abld85t0.execute-api.eu-central-1.amazonaws.com"
    }
}
