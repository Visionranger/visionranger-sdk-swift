//
//  NSMutableURLRequest+Visionranger.swift
//  NSMutableURLRequest+Visionranger
//
//  Created by Colin Tessarzick on 23.09.21.
//

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
