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
    
    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()
    
    var apiURL: URL! = URL(string: APIBaseURL)
    
    func configuredRequest(for url: URL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        return request
    }
    
    let urlSession = URLSession(configuration: VisionrangerAPIConfiguration.sharedURLSessionConfiguration)
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
        let endpoint = VSNAPIPath.products
        VSNRequest<VSNProduct>.post(with: self, endpoint: endpoint, parameters: paramters) { product, _, error in
            completion(product, error)
        }
    }
}

private let APIVersion = "2021-09-23"
private let APIBaseURL: String = "https://api.visionranger.com"
