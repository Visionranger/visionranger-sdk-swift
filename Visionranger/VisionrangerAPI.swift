//
//  VisionrangerAPI.swift
//  VisionrangerAPI
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

/// A top-level class that imports the rest of the Visionranger SDK.
public class VisionrangerAPI: NSObject {
    
    @objc public static var defaultAccessKey: String?
    
    public func setDefaultAccessKey(_ accessKey: String) {
        VisionrangerAPI.defaultAccessKey = accessKey
    }
    
    public static var environment: VSNDevelopmentEnvironment = .live
    
    public func setCurrentEnvironment(_ environment: VSNDevelopmentEnvironment) {
        VisionrangerAPI.environment = environment
    }
}
