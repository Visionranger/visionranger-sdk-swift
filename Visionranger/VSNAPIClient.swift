//
//  VSNAPIClient.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 22.09.21.
//
//  Copyright © 2020-2021 Visionranger e.K. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// A shared client, used to making network requests to the Visionranger API
public class VSNAPIClient: NSObject {
    
    /// The current version of this library
    @objc public static let VSNSDKVersion = VisionrangerAPIConfiguration.VSNSDKVersion
    
    /// A shared instance of the API client. Useful for upcoming usecases with extensive monitoring and computer vision network tasks
    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()
    
    /// Constructing a `URL` from the API host
    var apiURL: URL! = URL(string: APIBaseURL)
    
    /// A default `URLRequest` to set the default headers
    /// - Parameter url: The `URL` path that should be used for this task
    /// - Returns: Returns a mutable `URLRequest`
    ///
    /// Used on all networking requests to let users change request if necessary
    func configuredRequest(for url: URL, additionalHeaders: [String : String]) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        var headers = defaultheaders
        for (k, v) in additionalHeaders { headers[k] = v }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    /// A `URLSession` that uses a shared configuration for all network requests to the Visinoranger API
    let urlSession = URLSession(configuration: VisionrangerAPIConfiguration.sharedURLSessionConfiguration)
    
    @objc var defaultheaders: [String : String] {
        var defaultHeaders: [String : String] = [:]
        defaultHeaders["Visionranger-Version"] = APIVersion
        defaultHeaders["Visionranger-SDK-Version"] = "swift-ios/\(VSNAPIClient.VSNSDKVersion)"
        defaultHeaders["Visionranger-Mode"] = VisionrangerAPI.environment.rawValue
        defaultHeaders["X-API-Key"] = VisionrangerAPI.defaultAccessKey
        return defaultHeaders
    }
}

// MARK: Products
extension VSNAPIClient {
    /// Retrieve a product object
    /// - Parameters:
    ///   - id: The unique identifier of the product
    ///   - completion: Returns a product object when successful and an error when not
    public func retrieveProduct(id: String, _ completion: @escaping VSNProductCompletionBlock) {
        VSNRequest<VSNProduct>.getWith(
            self,
            endpoint: .products,
            parameters: ["id": id]
        ) { product, _, error in
            completion(product, error)
        }
    }
    
    /// List all products from a specified category
    /// - Parameters:
    ///   - paramters: The object's properties that should be changed
    ///   - completion: Returns an array of product objects when successful and an error when not
    public func listProducts(withParameters parameters: VSNParameters, _ completion: @escaping VSNProductsCompletionBlock) {
        var shared_Products = [VSNProduct]()
        var shared_lastError: Error? = nil
        let group = DispatchGroup()
        
        group.enter()
        
        VSNRequest<VSNProductListDeserializer>.getWith(
            self,
            endpoint: .listProducts,
            parameters: parameters
        ) { deserializer, _, error in
            DispatchQueue.global(qos: .userInteractive).async(flags: .barrier) {
                // .barrier ensures we're the only thing writing to shared_ vars
                if let error = error {
                    shared_lastError = error
                }
                if let products = deserializer?.products {
                    shared_Products.append(contentsOf: products)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(shared_Products, shared_lastError)
        }
    }
    
    /// Create a new product object with the specified parameters
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Return the newly created product object when successful and an error when not.
    public func createProduct(withParameters parameters: VSNParameters, _ completion: @escaping VSNProductCompletionBlock) {
        VSNRequest<VSNProduct>.post(
            with: self,
            endpoint: .products,
            parameters: parameters
        ) { product, _, error in
            completion(product, error)
        }
    }
    
    /// Updates a product object with the specified parameters
    /// - Parameters:
    ///   - paramters: The object's properties that should be changed
    ///   - completion: Return the updated product object when successful and an error when not
    public func updateProduct(withParameters paramters: VSNParameters, _ completion: @escaping VSNProductCompletionBlock) {
        VSNRequest<VSNProduct>.put(
            with: self,
            endpoint: .products,
            parameters: paramters
        ) { product, _, error in
            completion(product, error)
        }
    }
    
    /// Deletes a product object with the specified ID
    /// - Parameters:
    ///   - id: The unique identifier of the object to be deleted
    ///   - completion: Returns an empty body with the HTTP statuscode 204 when successful and an error when not
    public func deleteProduct(id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .products,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
}

// MARK: Announcements
extension VSNAPIClient {
    /// Retrieves the latest ``VSNAnnouncement`` object.
    /// - Parameter completion: Returns a ``VSNAnnouncement`` object when successful and an error when not
    public func retrieveAnnouncement(_ completion: @escaping VSNAnnouncementCompletionBlock) {
        VSNRequest<VSNAnnouncement>.getWith(
            self,
            endpoint: .announcements,
            parameters: [:]
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Creates a new ``VSNAnnouncement`` object. Will be displayed on top of the Catalog.
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Returns the newly created object when successful and an error when not
    ///
    ///   - Bug: Currently, this function does not return the newly created object, but the most applicable for In-App usage.
    ///   If you create a new announcement, that looses its validity before an existing object, that object will be returned.
    ///   For reference look at ``retrieveAnnouncement(_:)``
    ///
    ///   - Precondition: The `valid_until` property must be a [unix timestamp](https://en.wikipedia.org/wiki/Unix_time), not of type ``Date``.
    ///
    ///   - SeeAlso: ``VSNAnnouncement``
    public func createAnnouncement(withParameters parameters: [String: Any], _ completion: @escaping VSNAnnouncementCompletionBlock) {
        VSNRequest<VSNAnnouncement>.post(
            with: self,
            endpoint: .announcements,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Deletes a specified ``VSNAnnouncement`` object. Can only be processed by **selected users**.
    /// - Parameters:
    ///   - id: The unique identifier of the object
    ///   - completion: Returns a ``VSNDeletion`` object when successful and an error when not
    ///
    /// - Attention: This function does not actually delete the announcement, but archives it.
    ///
    /// When an announcement looses its validity, the object is automatically archived.
    /// This process allows selected users to post new announcements at a faster pace and distribute them just-in-time.
    public func deleteAnnouncement(id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .announcements,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
}

private let APIVersion = "2021-09-23"
private let APIBaseURL: String = "https://api.visionranger.com"
