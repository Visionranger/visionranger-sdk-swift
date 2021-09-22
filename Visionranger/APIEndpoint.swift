//
//  APIEndpoint.swift
//  APIEndpoint
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public protocol APIEndpointDelegate {
    var body: Data? { get }
    var headers: [String: String]? { get }
    var host: String { get }
    var method: VSNHTTPMethod { get }
    var path: VSNAPIPath { get }
    var query: [URLQueryItem] { get }
}

public extension APIEndpointDelegate {

    var headers: [String: String]? {
        return nil
    }

    var host: String {
        return "https://k9abld85t0.execute-api.eu-central-1.amazonaws.com"
    }

    var url: URL {
        var components = URLComponents(string: host)
        components?.path = path.rawValue
        components?.queryItems = query
        guard let url = components?.url else {
            preconditionFailure("Could not generate URL from endpoint object.")
        }
        return url
    }
    
    func queryBuilder(_ queries: (name: String, value: String)...) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for query in queries {
            if query.name.isEmpty || query.value.isEmpty {
                continue
            }
            queryItems.append(URLQueryItem(name: query.name, value: query.value))
        }
        return queryItems
    }
}


public class APIEndpoint: APIEndpointDelegate {
    
    public var method: VSNHTTPMethod
    
    public var path: VSNAPIPath
    
    public var query: [URLQueryItem]
    
    public var body: Data?
    
    public init(method: VSNHTTPMethod, path: VSNAPIPath, query: [URLQueryItem]? = []) {
        self.method = method
        self.path = path
        self.query = query ?? []
    }
}


public enum VSNHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case update = "PATCH"
}


public enum VSNAPIPath: String {
    case products = "/products"
    case configurations = "/configurations"
    case manufacturers = "/manufacturers"
    case orders = "/orders"
    case paymentMethods = "/paymentMethods"
    case designers = "/designers"
}
