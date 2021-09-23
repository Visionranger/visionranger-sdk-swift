//
//  VSNAPIClient.swift
//  VSNAPIClient
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

/// A shared client, used to making network requests to the Visionranger API
public class VSNAPIClient: NSObject {
    
    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()
    
    var apiURL: URL! = URL(string: APIBaseURL)
    
    func configuredRequest(for url: URL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        return request
    }
}

// MARK: Products
extension VSNAPIClient {
    /// Retrieve a product object
    /// - Parameters:
    ///   - id: The unique identifier of the product
    ///   - completion: Returns a product object when successful and an error when not
    public func retrieveProduct(id: String, _ completion: @escaping VSNProductCompletionBlock) {
        let request = VSNRequest<VSNProduct>(method: .get, path: .products, session: URLSession.shared)!
        request.parameter = ["id": id, "mode": VisionrangerAPI.environment]
        request.execute() { response, error in
            guard let response = response, error == nil else {
                completion(nil, error)
                return
            }
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            let product = try! decoder.decode(VSNProduct.self, from: jsonData)
            completion(product, nil)
            return
        }
    }
    
    /// List all products from a specified category
    /// - Parameters:
    ///   - category: The category the retrieved products belong to
    ///   - completion: Returns an array of product objects when successful and an error when not
    public func listProducts(forCategory category: String, _ completion: @escaping VSNProductsCompletionBlock) {
        let request = VSNRequest<VSNProduct>(method: .get, path: .products, session: URLSession.shared)!
        request.parameter = ["mode": VisionrangerAPI.environment, "category": category]
        request.execute() { response, error in
            guard let response = response, error == nil else {
                completion(nil, error)
                return
            }
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            let products = try! decoder.decode([VSNProduct].self, from: jsonData)
            completion(products, nil)
            return
        }
    }
    
    public func updateProduct(withParameters paramters: VSNParameter, _ completion: @escaping VSNProductCompletionBlock) {
        let request = VSNRequest<VSNProduct>(method: .update, path: .products, session: URLSession.shared)!
        request.parameter = paramters
        request.execute() { response, error in
            guard let response = response, error == nil else {
                completion(nil, error)
                return
            }
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            let product = try! decoder.decode(VSNProduct.self, from: jsonData)
            completion(product, nil)
            return
        }
    }
}

private let APIVersion = "2021-09-23"
private let APIBaseURL: String = "https://k9abld85t0.execute-api.eu-central-1.amazonaws.com"
