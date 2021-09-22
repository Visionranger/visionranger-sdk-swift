//
//  VisionrangerAPI.swift
//  VisionrangerAPI
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VisionrangerAPI: NSObject {
    
    ///  Set this to your Visionranger Access Key, obtained from https://hub.visionranger.com/apikey.
    ///  Set this as early as possible in your application's lifecycle, preferably in your AppDelete or SceneDelegate.
    ///  New instances of VisionrangerAPIClient will be initialized with this value.
    @objc public static var defaultAccessKey: String?
    
    public func setDefaultAccessKey(_ accessKey: String) {
        VisionrangerAPI.defaultAccessKey = accessKey
    }
    
    @objc public static var maxRetries = 3
}
