//
//  VSNAPIClient.swift
//  VSNAPIClient
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation
import UIKit

/// A client for making network requests to the Visionranger API.
public class VSNAPIClient: NSObject {
    
    /// The current version of this library.
    @objc public static let VSNSDKVersion = VisionrangerAPIConfiguration.VSNSDKVersion
    
    /// A shared singleton API client.
    /// By default, the SDK uses this instance to make API requests
    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()
    
    @objc public var accessKey: String? {
        get {
            if let accessKey = _accessKey {
                return accessKey
            }
            return VisionrangerAPI.defaultAccessKey
        }
        set {
            _accessKey = newValue
            Self.validateKey(newValue)
        }
    }
    var _accessKey: String?
    
    class func validateKey(_ accessKey: String?) {
        guard let accessKey = accessKey, !accessKey.isEmpty else {
            assertionFailure(
                "You must use a valid access key. For more info, contact your account manager from Visionranger."
            )
            return
        }
    }
}

// MARK: Products
/// The API allows you to create, delete and update a product.
/// You can retrieve individual products as well as a list of all products.
extension VSNAPIClient {
    
    /// Use this API request to create a new product.
    /// - Parameters:
    ///   - session: The `URLSession` to use when calling this function.
    ///   This is used for convenience, when your application is performing multiple network requests at once.
    ///   - completion: This API request returns the JSON product object from the newly created product.
    public func createProduct(product: Product, session: URLSession, _ completion: @escaping(_ response: String?, _ error: VSNError?) -> Void) {
        let endpoint = APIEndpoint(method: .post, path: .products)
        
        let request = Request(session: session, endpoint: endpoint)
        request?.execute() { response in
            guard let _ = response.data else {
                completion(nil, response.error)
                return
            }
            let json = response.toJSONString()
            completion(json, nil)
            return
        }
    }
    
    public func retrieveProduct(id: String, session: URLSession, _ completion: @escaping(_ product: String?, _ error: VSNError?) -> Void) {
        let endpoint = APIEndpoint(method: .get, path: .products)
        endpoint.query = endpoint.queryBuilder((name: "id", value: id))
        
        let request = Request(session: session, endpoint: endpoint)
        request?.execute() { response in
            guard let _ = response.data else {
                completion(nil, response.error)
                return
            }
            let json = response.toJSONString()
            completion(json, nil)
            return
        }
    }
    
    public func listProducts(category: VSNProductCategory, session: URLSession, _ completion: @escaping(_ list: String?, _ error: VSNError?) -> Void) {
        let endpoint = APIEndpoint(method: .get, path: .products)
        endpoint.query = endpoint.queryBuilder((name: "category", value: category.rawValue))
        
        let request = Request(session: session, endpoint: endpoint)
        request?.execute() { response in
            guard let _ = response.data else {
                completion(nil, response.error)
                return
            }
            let json = response.toJSONString()
            completion(json, nil)
            return
        }
    }
    
    public func deleteProduct(id: String, session: URLSession, _ completion: @escaping(_ response: String?, _ error: VSNError?) -> Void) {
        let endpoint = APIEndpoint(method: .delete, path: .products)
        endpoint.query = endpoint.queryBuilder((name: "id", value: id))
        
        let request = Request(session: session, endpoint: endpoint)
        request?.execute() { response in
            guard let _ = response.data else {
                completion(nil, response.error)
                return
            }
            let json = response.toJSONString()
            completion(json, nil)
            return
        }
    }
    
    public func updateProduct(id: String, session: URLSession, _ completion: @escaping(_ response: String?, _ error: VSNError?) -> Void) {
        let endpoint = APIEndpoint(method: .update, path: .products)
        endpoint.query = endpoint.queryBuilder((name: "id", value: id))
        
        let request = Request(session: session, endpoint: endpoint)
        request?.execute() { response in
            guard let _ = response.data else {
                completion(nil, response.error)
                return
            }
            let json = response.toJSONString()
            completion(json, nil)
            return
        }
    }
}
