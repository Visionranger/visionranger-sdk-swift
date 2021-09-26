//
//  URLSession+Retry.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 25.09.21.
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

extension URLSession {
    /// The default method to use, when performing any network requests to the Visionranger API
    /// - Parameters:
    ///   - request: The `URLRequest` to be used to perform the network task
    ///   - completionHandler: Returns the default set of network outputs (body, headers and error)
    ///   - retryCount: How many times the network request should retry before returning a `429` error
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
