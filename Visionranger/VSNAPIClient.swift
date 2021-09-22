//
//  VSNAPIClient.swift
//  VSNAPIClient
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VSNAPIClient: NSObject {
    
    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()
}

// MARK: Products
extension VSNAPIClient {
    public func retrieveProduct(id: String, _ completion: @escaping VSNProductCompletionBlock) {
        let request = VSNRequest(method: .get, path: .products, session: URLSession.shared)
        request.query = [URLQueryItem(name: "id", value: id)]
    }
}
