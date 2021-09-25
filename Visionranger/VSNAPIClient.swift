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
    
    let urlSession = URLSession(configuration: <#T##URLSessionConfiguration#>)
}

// MARK: Products
extension VSNAPIClient {
    /// Retrieve a product object
    /// - Parameters:
    ///   - id: The unique identifier of the product
    ///   - completion: Returns a product object when successful and an error when not
    public func retrieveProduct(id: String, _ completion: @escaping VSNProductCompletionBlock) {

    }
    
    /// List all products from a specified category
    /// - Parameters:
    ///   - category: The category the retrieved products belong to
    ///   - completion: Returns an array of product objects when successful and an error when not
    public func listProducts(forCategory category: String, _ completion: @escaping VSNProductsCompletionBlock) {

    }
    
    public func updateProduct(withParameters paramters: VSNParameter, _ completion: @escaping VSNProductCompletionBlock) {

    }
}

private let APIVersion = "2021-09-23"
private let APIBaseURL: String = "https://api.visionranger.com"
