//
//  VisionrangerAPIConfiguration+Version.swift
//  VisionrangerAPIConfiguration+Version
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public extension VisionrangerAPIConfiguration {
    
    static let VSNSDKVersion = "0.1.0"
    
    /*
     NOTE: `VSNSDKVersion` must be a hard-coded static string instead of
     dynamically generated from the bundle's `CFBundleShortVersionString` to
     ensure the correct value is returned when the SDK is statically linked.
     */
}
