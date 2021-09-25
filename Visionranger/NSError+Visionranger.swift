//
//  NSError+Visionranger.swift
//  NSError+Visionranger
//
//  Created by Colin Tessarzick on 25.09.21.
//

import Foundation

public extension NSError {
    class func vsn_unexpectedErrorMessage() -> String {
        return "There was an unexpected error. Try again in a few seconds."
    }
    
    class func vsn_genericFailedToParseReponseError() -> NSError {
        let userInfo = [
            NSLocalizedDescriptionKey: self.vsn_unexpectedErrorMessage()
        ]
        return NSError(domain: "com.visionranger.lib", code: 60, userInfo: userInfo)
    }
}
