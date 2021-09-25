//
//  URLSession+Retry.swift
//  URLSession+Retry
//
//  Created by Colin Tessarzick on 25.09.21.
//

import Foundation

extension URLSession {
    func vsn_performDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, retryCount: Int = VisionrangerAPI.maxRetries) {
        let task = dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 429,
               retryCount > 0 {
                // Add some backoff time with a little bit of jitter:
                let delayTime = TimeInterval(
                    pow(Double(1 + VisionrangerAPI.maxRetries - retryCount), Double(2)) + .random(in: 0..<0.5)
                )
                
                if #available(iOS 13.0, *) {
                    let fireDate = Date() + delayTime
                    self.delegateQueue.schedule(after: .init(fireDate)) {
                        self.vsn_performDataTask(with: request, completionHandler: completionHandler, retryCount: retryCount - 1)
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                        self.delegateQueue.addOperation {
                            self.vsn_performDataTask(with: request, completionHandler: completionHandler, retryCount: retryCount - 1)
                        }
                    }
                }
            } else {
                completionHandler(data, response, error)
            }
        }
        task.resume()
    }
}
