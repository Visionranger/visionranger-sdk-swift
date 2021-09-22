//
//  Request.swift
//  Request
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class Response: NSObject {
    
    @objc public var data: Data?
    
    @objc public var statusCode: Int
    
    @objc public var response: HTTPURLResponse?
    
    @objc public var error: VSNError?
    
    @objc public init(data: Data?, statusCode: Int, response: HTTPURLResponse?, error: VSNError?) {
        self.data = data
        self.statusCode = statusCode
        self.response = response
        self.error = error
    }
    
    func toJSONString() -> String {
        guard let data = data else {
            return ""
        }
        return String(data: data, encoding: String.Encoding.utf8)!
    }
}


public class Request {
    let session: URLSession?
    let endpoint: APIEndpoint
    public private(set) var urlRequest: URLRequest
    
    public init?(session: URLSession?, endpoint: APIEndpoint) {
        guard var components = URLComponents(string: endpoint.host) else {
            return nil
        }
        components.path = endpoint.path.rawValue
        components.queryItems = endpoint.query

        guard let url = components.url else {
            return nil
        }
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body

        self.session = session
        self.endpoint = endpoint
    }
    
    private func addHeaders() {
        urlRequest.setValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")

        if let versionNumber = Bundle(for: type(of: self)).object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            urlRequest.setValue("iOS SDK v\(versionNumber)", forHTTPHeaderField: "X-Visionranger-User-Agent")
        }
        if let token = VisionrangerAPI.defaultAccessKey {
            urlRequest.setValue("Access \(token)", forHTTPHeaderField: "Authorization")
        }
        if let headers = endpoint.headers {
            for (header,value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: header)
            }
        }
    }
    
    public func prepare() {
        addHeaders()
    }
    
    public func execute(_ completion: @escaping (_ response: Response) -> Void) {
        guard let session = session else {
            return
        }
        
        addHeaders()
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            let httpResponse: HTTPURLResponse? = response as? HTTPURLResponse
            var statusCode: Int = 0
            var vsnError: VSNError?
            
            // Handle HTTP errors.
            errorCheck: if httpResponse != nil {
                statusCode = httpResponse!.statusCode
                
                if statusCode <= 299 {
                    break errorCheck
                }
                
                if statusCode >= 400 && statusCode <= 499 {
                    vsnError = try? JSONDecoder.vsnDecoder.decode(VSNClientError.self, from: data!)
                } else if (statusCode >= 500 && statusCode <= 599) {
                    vsnError = try? JSONDecoder.vsnDecoder.decode(VSNServerError.self, from: data!)
                } else {
                    vsnError = try? JSONDecoder.vsnDecoder.decode(VSNUnknownError.self, from: data!)
                }
                
                vsnError?.status = statusCode
            }
            
            // Any other errors.
            if response == nil || error != nil {
                if let error = error as NSError? {
                    vsnError = VSNUnknownError(status: error.code, code: nil, title: error.domain)
                } else {
                    vsnError = VSNUnknownError(status: -1, code: "request_error", title: "Request could not complete")
                }
            }
          
            let vsnResponse = Response(data: data, statusCode: statusCode, response: httpResponse, error: vsnError)
            completion(vsnResponse)
        })
        task.resume()
    }
}
