//
//  VSNRequest.swift
//  VSNRequest
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

class VSNRequest<ResponseType: VSNAPIResponseDecodable>: NSObject, VSNRequestDelegate {
    typealias VSNAPIResponseBlock = (ResponseType?, HTTPURLResponse?, Error?) -> Void
    
    public var parameter: VSNParameter?
    
    public var body: Data?
    
    public var path: VSNAPIPath
    
    public var method: VSNHTTPMethod
    
    public var session: URLSession
    
    public private(set) var request: URLRequest?
    
    public init?(method: VSNHTTPMethod, path: VSNAPIPath, session: URLSession) {
        self.method = method
        self.path = path
        self.session = session
    }
    
    public func queryBuilder(_ queries: VSNParameter) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
            for (key, value) in queries {
                let queryItem = URLQueryItem(name: key, value: String(describing: value))
                queryItems.append(queryItem)
            }
        return queryItems
    }
    
    /// Executes a network request to the Visionranger API
    /// - Parameter completion: Returns a JSON response when successful or an error when not
    ///
    /// Before calling this function, make sure to setup all resources and variables.
    /// When the network request is a get or delete request, you have to specify the parameters, required to get a successful response from the server.
    /// When the network request is a pathc or post request, you have to specify the body in JSON format, required to get a successful response from the server.
    public func execute(_ completion: @escaping VSNJSONResponseCompletionBlock) {
        guard var components = URLComponents(string: self.host) else {
            return
        }
        components.path = path.rawValue
        if let parameter = parameter {
            components.queryItems = queryBuilder(parameter)
        }
        
        guard let url = components.url else {
            return
        }
        request = URLRequest(url: url)
        request!.httpMethod = self.method.rawValue
        request!.httpBody = self.body
        
        if let token = VisionrangerAPI.defaultAccessKey {
            request?.setValue("Access \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = session.dataTask(with: request!) { data, response, error in
            let httpResponse: HTTPURLResponse? = response as? HTTPURLResponse
            var statusCode: Int = 0
            
            errorCheck: if httpResponse != nil {
                statusCode = httpResponse!.statusCode
                
                if statusCode <= 299 {
                    break errorCheck
                }
                
                if statusCode >= 400 && statusCode <= 499 {
                    print("An error occured on the client.")
                    completion(nil, error)
                    return
                } else if statusCode >= 500 && statusCode <= 599 {
                    print("An error occured on the server.")
                    completion(nil, error)
                    return
                } else {
                    print("An unknown error occured.")
                    completion(nil, error)
                    return
                }
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            let json = String(data: data, encoding: .utf8)
            completion(json, nil)
            return
        }
        task.resume()
    }
    
    class func post(with client: VSNAPIClient, endpoint: VSNAPIPath, parameters: [String: Any], _ completion: @escaping VSNAPIResponseBlock) {
        let url = client.apiURL.appendingPathComponent(endpoint.rawValue)
        let request = client.configuredRequest(for: url)
        request.httpMethod = VSNHTTPMethod.post.rawValue
        request.vsn_setFormPayload(parameters)
    }
}

/// A set of variables that are required for every network request to the Visionranger API.
public protocol VSNRequestDelegate {
    var host: String { get }
    var path: VSNAPIPath { get }
    var method: VSNHTTPMethod { get }
    var session: URLSession { get }
    var body: Data? { get }
    var parameter: VSNParameter? { get }
}

public extension VSNRequestDelegate {
    
    var host: String {
        return "https://k9abld85t0.execute-api.eu-central-1.amazonaws.com"
    }
}
