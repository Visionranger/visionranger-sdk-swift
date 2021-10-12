//
//  VSNRequest.swift
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

class VSNRequest<ResponseType: VSNAPIResponseDecodable>: NSObject {
    typealias VSNAPIResponseBlock = (ResponseType?, HTTPURLResponse?, Error?) -> Void
    
    class func post(
        with client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String: Any],
        additionalHeaders: [String : String] = [:],
        _ completion: @escaping VSNAPIResponseBlock
    ) {
        // Construct URL
        let url = client.apiURL.appendingPathComponent(endpoint.rawValue)
        
        // Setup URLRequest
        let request = client.configuredRequest(for: url, additionalHeaders: additionalHeaders)
        request.httpMethod = VSNHTTPMethod.post.rawValue
        request.vsn_addParameters(toURL: parameters)
        
        // Perform network task
        client.urlSession.vsn_performDataTask(
            with: request as URLRequest,
            completionHandler: { body, response, error in
                self.parseResponse(response, body: body, error: error, completion: completion)
        })
    }
    
    class func getWith(
        _ client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String : Any],
        _ completion: @escaping VSNAPIResponseBlock
    ) {
        self.getWith(
            client,
            endpoint: endpoint,
            parameters: parameters,
            additionalHeaders: [:],
            completion
        )
    }
    
    class func getWith(
        _ client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String: Any],
        additionalHeaders: [String : String],
        _ completion: @escaping VSNAPIResponseBlock
    ) {
        let url = client.apiURL.appendingPathComponent(endpoint.rawValue)
        
        let request = client.configuredRequest(for: url, additionalHeaders: additionalHeaders)
        request.httpMethod = VSNHTTPMethod.get.rawValue
        request.vsn_addParameters(toURL: parameters)
        
        client.urlSession.vsn_performDataTask(
            with: request as URLRequest,
            completionHandler: { body, response, error in
                self.parseResponse(response, body: body, error: error, completion: completion)
        })
    }
    
    class func put(
        with client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String : Any],
        completion: @escaping VSNAPIResponseBlock
    ) {
        self.put(
            with: client,
            endpoint: endpoint,
            parameters: parameters,
            additionalHeaders: [:],
            completion: completion
        )
    }
    
    class func put(
        with client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String : Any],
        additionalHeaders: [String : String],
        completion: @escaping VSNAPIResponseBlock
    ) {
        let url = client.apiURL.appendingPathComponent(endpoint.rawValue)
        
        let request = client.configuredRequest(for: url, additionalHeaders: additionalHeaders)
        request.httpMethod = VSNHTTPMethod.put.rawValue
        request.vsn_addParameters(toURL: parameters)
        
        client.urlSession.vsn_performDataTask(
            with: request as URLRequest,
            completionHandler: { body, response, error in
                self.parseResponse(response, body: body, error: error, completion: completion)
        })
    }
    
    class func delete(
        with client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String : Any],
        completion: @escaping VSNAPIResponseBlock
    ) {
        self.delete(
            with: client,
            endpoint: endpoint,
            parameters: parameters,
            additionalHeaders: [:],
            completion: completion
        )
    }
    
    class func delete(
        with client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String: Any],
        additionalHeaders: [String : String],
        completion: @escaping VSNAPIResponseBlock
    ) {
        let url = client.apiURL.appendingPathComponent(endpoint.rawValue)
        
        let request = client.configuredRequest(for: url, additionalHeaders: additionalHeaders)
        request.httpMethod = VSNHTTPMethod.delete.rawValue
        request.vsn_addParameters(toURL: parameters)
        
        client.urlSession.vsn_performDataTask(
            with: request as URLRequest,
            completionHandler: { body, response, error in
                self.parseResponse(response, body: body, error: error, completion: completion)
        })
    }
    
    class func parseResponse<ResponseType: VSNAPIResponseDecodable>(
        _ response: URLResponse?,
        body: Data?,
        error: Error?,
        completion: @escaping (ResponseType?, HTTPURLResponse?, Error?) -> Void
    ) {
        // Derive HTTP URL response
        var httpResponse: HTTPURLResponse?
        if response is HTTPURLResponse {
            httpResponse = response as? HTTPURLResponse
        }

        // Wrap completion block with main thread dispatch
        let safeCompletion: ((ResponseType?, Error?) -> Void) = { responseObject, responseError in
            vsnDispatchToMainThreadIfNecessary({
                completion(responseObject, httpResponse, responseError)
            })
        }

        if error != nil {
            // Forward NSURLSession error
            return safeCompletion(nil, error)
        }

        // Parse JSON response body
        var jsonDictionary: [AnyHashable: Any]?
        if let body = body {
            do {
                jsonDictionary =
                    try JSONSerialization.jsonObject(with: body, options: []) as? [AnyHashable: Any]
            } catch { }
        }

        if let responseObject = ResponseType.decodedObject(fromAPIResponse: jsonDictionary) {
            safeCompletion(responseObject, nil)
        } else {
            let error: Error = NSError.vsn_genericFailedToParseResponseError()
            safeCompletion(nil, error)
        }
    }
}

public enum VSNHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


public enum VSNAPIPath: String {
    case products = "/products"
    case listProducts = "/products/list"
    case configurations = "/configurations"
    case announcements = "/announcements"
}
