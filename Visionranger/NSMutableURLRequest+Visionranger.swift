//
//  NSMutableURLRequest+Visionranger.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 23.09.21.
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

extension NSMutableURLRequest {
    
    public func vsn_addParameters(toURL parameters: [String: Any]) {
        guard let url = url else {
            assertionFailure()
            return
        }
        let urlString = url.absoluteString
        let query = URLEncoder.queryString(from: parameters)
        self.url = URL(string: urlString + (url.query != nil ? "&\(query)" : "?\(query)"))
    }
    
    public func vsn_setFormPayload(_ formPayload: [String: Any]) {
        let formData = URLEncoder.queryString(from: formPayload).data(using: .utf8)
        httpBody = formData
        setValue(
            String(format: "%lu", UInt(formData?.count ?? 0)), forHTTPHeaderField: "Content-Length")
        setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
}
