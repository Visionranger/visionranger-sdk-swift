//
//  VSNRequest.swift
//  VSNRequest
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

class VSNRequest<ResponseType: VSNAPIResponseDecodable>: NSObject {
    typealias VSNAPIResponseBlock = (ResponseType?, HTTPURLResponse?, Error?) -> Void
    
    class func post(
        with client: VSNAPIClient,
        endpoint: VSNAPIPath,
        parameters: [String: Any],
        _ completion: @escaping VSNAPIResponseBlock
    ) {
        // Construct URL
        let url = client.apiURL.appendingPathComponent(endpoint.rawValue)
        
        // Setup URLRequest
        let request = client.configuredRequest(for: url)
        request.httpMethod = VSNHTTPMethod.post.rawValue
        request.vsn_setFormPayload(parameters)
        
        // Perform network task
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
            let error: Error = NSError.vsn_genericFailedToParseReponseError()
            safeCompletion(nil, error)
        }
    }
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
