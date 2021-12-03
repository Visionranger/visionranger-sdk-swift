//
//  VSNAPIClient.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 22.09.21.
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
import UIKit

/// A shared client, used to making network requests to the Visionranger API
public class VSNAPIClient: NSObject {
    
    /// The current version of this library
    @objc public static let VSNSDKVersion = VisionrangerAPIConfiguration.VSNSDKVersion
    
    /// A shared instance of the API client. Useful for upcoming usecases with extensive monitoring and computer vision network tasks
    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()
    
    public var appInfo: VSNAppInfo?
    
    /// Constructing a `URL` from the API host
    var apiURL: URL! = URL(string: APIBaseURL)
    
    /// A default `URLRequest` to set the default headers
    /// - Parameter url: The `URL` path that should be used for this task
    /// - Returns: Returns a mutable `URLRequest`
    ///
    /// Used on all networking requests to let users change request if necessary
    func configuredRequest(for url: URL, additionalHeaders: [String : String]) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        var headers = defaultheaders 
        for (k, v) in additionalHeaders { headers[k] = v }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    /// A `URLSession` that uses a shared configuration for all network requests to the Visinoranger API
    let urlSession = URLSession(configuration: VisionrangerAPIConfiguration.sharedURLSessionConfiguration)
    
    @objc var defaultheaders: [String : String] {
        var defaultHeaders: [String : String] = [:]
        defaultHeaders["X-Visionranger-User-Agent"] = VSNAPIClient.visionrangerUserAgentDetails(with: appInfo)
        defaultHeaders["Visionranger-Version"] = APIVersion
        defaultHeaders["Visionranger-SDK-Version"] = "swift-ios/\(VSNAPIClient.VSNSDKVersion)"
        defaultHeaders["Visionranger-Mode"] = VisionrangerAPI.environment.rawValue
        defaultHeaders["X-API-Key"] = VisionrangerAPI.defaultAccessKey
        return defaultHeaders
    }
    
    class func visionrangerUserAgentDetails(with appInfo: VSNAppInfo?) -> String {
        var details: [String: String] = [
            "language": "swift",
            "bindings_version": VSNSDKVersion,
        ]
        let version = UIDevice.current.systemVersion
        if version != "" {
            details["os_version"] = version
        }
        let locale = Locale.current.languageCode
        if locale != "" {
            details["locale"] = locale
        }
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        details["type"] = mapDeviceTypeIdentifier(identifier: identifier)
        let model = UIDevice.current.localizedModel
        if model != "" {
            details["model"] = model
        }
        
        let vendorIdentifier = UIDevice.current.identifierForVendor?.uuidString
        if let vendorIdentifier = vendorIdentifier {
            details["vendor_identifier"] = vendorIdentifier
        }
        if let appInfo = appInfo {
            details["name"] = appInfo.name
            details["partner_id"] = appInfo.partnerId
            if appInfo.version != nil {
                details["version"] = appInfo.version
            }
            if appInfo.url != nil {
                details["url"] = appInfo.url
            }
            details["launch_configuration"] = appInfo.launchConfiguration?.rawValue
        }
        let data = try? JSONSerialization.data(withJSONObject: details, options: [])
        return String(data: data ?? Data(), encoding: .utf8) ?? ""
    }
    
    private class func mapDeviceTypeIdentifier(identifier: String) -> String {
        #if os(iOS)
        switch identifier {
        case "iPod5,1":                                       return "iPod touch (5th generation)"
        case "iPod7,1":                                       return "iPod touch (6th generation)"
        case "iPod9,1":                                       return "iPod touch (7th generation)"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
        case "iPhone4,1":                                     return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
        case "iPhone7,2":                                     return "iPhone 6"
        case "iPhone7,1":                                     return "iPhone 6 Plus"
        case "iPhone8,1":                                     return "iPhone 6s"
        case "iPhone8,2":                                     return "iPhone 6s Plus"
        case "iPhone8,4":                                     return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
        case "iPhone11,2":                                    return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
        case "iPhone11,8":                                    return "iPhone XR"
        case "iPhone12,1":                                    return "iPhone 11"
        case "iPhone12,3":                                    return "iPhone 11 Pro"
        case "iPhone12,5":                                    return "iPhone 11 Pro Max"
        case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
        case "iPhone13,1":                                    return "iPhone 12 mini"
        case "iPhone13,2":                                    return "iPhone 12"
        case "iPhone13,3":                                    return "iPhone 12 Pro"
        case "iPhone13,4":                                    return "iPhone 12 Pro Max"
        case "iPhone14,4":                                    return "iPhone 13 mini"
        case "iPhone14,5":                                    return "iPhone 13"
        case "iPhone14,2":                                    return "iPhone 13 Pro"
        case "iPhone14,3":                                    return "iPhone 13 Pro Max"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
        case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
        case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
        case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
        case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
        case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
        case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
        case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
        case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
        case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
        case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
        case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
        case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
        case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
        case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
        case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
        case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
        case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
        case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
        case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
        case "AppleTV5,3":                                    return "Apple TV"
        case "AppleTV6,2":                                    return "Apple TV 4K"
        case "AudioAccessory1,1":                             return "HomePod"
        case "AudioAccessory5,1":                             return "HomePod mini"
        case "i386", "x86_64", "arm64":                                return "Simulator \(mapDeviceTypeIdentifier(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
        default:                                              return identifier
        }
        #elseif os(tvOS)
        switch identifier {
        case "AppleTV5,3": return "Apple TV 4"
        case "AppleTV6,2": return "Apple TV 4K"
        case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
        default: return identifier
        }
        #endif
    }
}

// MARK: Products
extension VSNAPIClient {
    /// Retrieve a product object
    /// - Parameters:
    ///   - id: The unique identifier of the product
    ///   - completion: Returns a product object when successful and an error when not
    public func retrieveProduct(id: String, _ completion: @escaping VSNProductCompletionBlock) {
        VSNRequest<VSNProduct>.getWith(
            self,
            endpoint: .products,
            parameters: ["id": id]
        ) { product, _, error in
            completion(product, error)
        }
    }
    
    /// List all products from a specified category
    /// - Parameters:
    ///   - paramters: The object's properties that should be changed
    ///   - completion: Returns an array of product objects when successful and an error when not
    public func listProducts(withParameters parameters: VSNParameters, _ completion: @escaping VSNProductsCompletionBlock) {
        var shared_Products = [VSNProduct]()
        var shared_lastError: Error? = nil
        let group = DispatchGroup()
        
        group.enter()
        
        VSNRequest<VSNProductListDeserializer>.getWith(
            self,
            endpoint: .listProducts,
            parameters: parameters
        ) { deserializer, _, error in
            DispatchQueue.global(qos: .userInteractive).async(flags: .barrier) {
                // .barrier ensures we're the only thing writing to shared_ vars
                if let error = error {
                    shared_lastError = error
                }
                if let products = deserializer?.products {
                    shared_Products.append(contentsOf: products)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(shared_Products, shared_lastError)
        }
    }
    
    /// Create a new product object with the specified parameters
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Return the newly created product object when successful and an error when not.
    public func createProduct(withParameters parameters: VSNParameters, _ completion: @escaping VSNProductCompletionBlock) {
        VSNRequest<VSNProduct>.post(
            with: self,
            endpoint: .products,
            parameters: parameters
        ) { product, _, error in
            completion(product, error)
        }
    }
    
    /// Updates a product object with the specified parameters
    /// - Parameters:
    ///   - paramters: The object's properties that should be changed
    ///   - completion: Return the updated product object when successful and an error when not
    public func updateProduct(withParameters paramters: VSNParameters, _ completion: @escaping VSNProductCompletionBlock) {
        VSNRequest<VSNProduct>.put(
            with: self,
            endpoint: .products,
            parameters: paramters
        ) { product, _, error in
            completion(product, error)
        }
    }
    
    /// Deletes a product object with the specified ID
    /// - Parameters:
    ///   - id: The unique identifier of the object to be deleted
    ///   - completion: Returns an empty body with the HTTP statuscode 204 when successful and an error when not
    public func deleteProduct(id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .products,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
}

// MARK: Announcements
extension VSNAPIClient {
    /// Retrieves the latest ``VSNAnnouncement`` object.
    /// - Parameter completion: Returns a ``VSNAnnouncement`` object when successful and an error when not
    public func retrieveAnnouncement(_ completion: @escaping VSNAnnouncementCompletionBlock) {
        VSNRequest<VSNAnnouncement>.getWith(
            self,
            endpoint: .announcements,
            parameters: [:]
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Creates a new ``VSNAnnouncement`` object. Will be displayed on top of the Catalog.
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Returns the newly created object when successful and an error when not
    ///
    /// - Note: Creating a new announcement will make it visible to the general audience.
    ///   If you **later decide to remove or deactive** the announcement, call ``updateAnnouncement(withParameters:_:)`` and set
    ///  ```
    ///   active = false
    ///  ```
    /// - Requires: The following parameters must be provided:
    ///  ```
    ///   title: String
    ///   description: String
    ///   short_description: String
    ///   thumbnail: String // URL of the resource
    ///   valid_until: Double
    ///  ```
    /// - Attention: For practical use, specify at least one filter parameter. If none is provided the list will contain all available products - this is neither recommended nor practical.
    ///
    /// - Precondition: The `valid_until` property must be a [unix timestamp](https://en.wikipedia.org/wiki/Unix_time), not of type ``Date``.
    public func createAnnouncement(withParameters parameters: [String: Any], _ completion: @escaping VSNAnnouncementCompletionBlock) {
        VSNRequest<VSNAnnouncement>.post(
            with: self,
            endpoint: .announcements,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Deletes a specified ``VSNAnnouncement`` object. Can only be processed by **selected users**.
    /// - Parameters:
    ///   - id: The unique identifier of the object
    ///   - completion: Returns a ``VSNDeletion`` object when successful and an error when not
    ///
    /// - Attention: This function does not actually delete the announcement, but archives it.
    ///
    /// When an announcement looses its validity, the object is automatically archived.
    /// This process allows selected users to post new announcements at a faster pace and distribute them just-in-time
    public func deleteAnnouncement(id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .announcements,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Updates a specified ``VSNAnnouncement`` object. Can only be processed by **selected users**.
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Returns the updated ``VSNAnnouncement`` object when successful or an error when not.
    ///
    /// - Requires: `id` of the announcement
    ///
    /// This function takes the same properties as optional input parameters as ``createAnnouncement(withParameters:_:)`` does.
    /// In addition, you can also set the `active` property of the object. This value is `true` by default, but can be changed by **selected users**.
    public func updateAnnouncement(withParameters parameters: [String: Any], _ completion: @escaping VSNAnnouncementCompletionBlock) {
        VSNRequest<VSNAnnouncement>.put(
            with: self,
            endpoint: .announcements,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
}

// MARK: Configurations
extension VSNAPIClient {
    /// Returns a ``VSNConfiguration`` object with the specified unique identifier.
    /// - Parameters:
    ///   - id: The object's unique identifier
    ///   - completion: Returns the ``VSNConfiguration`` object when successful or an error when not.
    ///
    /// - Requires: `id` of the configuration
    public func retrieveConfiguration(with id: String, _ completion: @escaping VSNConfigurationCompletionBlock) {
        VSNRequest<VSNConfiguration>.getWith(
            self,
            endpoint: .configurations,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Lists all ``VSNConfiguration`` objects for a specified product.
    /// - Parameters:
    ///   - id: The unique identifier of the ``VSNProduct``
    ///   - completion: Returns metadata and an array of ``VSNConfiguration`` objects when successful or an error when not.
    ///
    /// - Requires: `id` of the product
    ///
    /// The output of this function depends on your application's current environment.
    /// When your app is in **test Mode**, this function will return only those configurations whose `active` property is set to `false`.
    /// This function returns the following structure:
    /// ```
    ///   "count": Int
    ///   "data": [VSNConfiguration]
    /// ```
    public func listConfigurations(forProduct id: String, _ completion: @escaping VSNConfigurationsCompletionBlock) {
        var shared_Configurations = [VSNConfiguration]()
        var shared_lastError: Error? = nil
        let group = DispatchGroup()
        
        group.enter()
        
        VSNRequest<VSNConfigurationListDeserializer>.getWith(
            self,
            endpoint: .listConfigurations,
            parameters: ["id": id]
        ) { deserializer, _, error in
            DispatchQueue.global(qos: .userInteractive).async(flags: .barrier) {
                // .barrier ensures we're the only thing writing to shared_ vars
                if let error = error {
                    shared_lastError = error
                }
                if let configurations = deserializer?.configurations {
                    shared_Configurations.append(contentsOf: configurations)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(shared_Configurations, shared_lastError)
        }
    }
    
    /// Creates a new ``VSNConfiguration`` object
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Returns the newly created object when successful and an error when not
    ///
    /// - Note: Your application's environment determins whether the object will only be available in Testmode or publically available to all users.
    /// - Requires: The following parameters must be provided:
    ///  ```
    ///   "product_id": String
    ///   "price": Double
    ///   "model_url": String
    ///   "image_url": String
    ///   "sku": String
    ///  ```
    public func createConfiguration(withParameters parameters: [String: Any], _ completion: @escaping VSNConfigurationCompletionBlock) {
        VSNRequest<VSNConfiguration>.post(
            with: self,
            endpoint: .configurations,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Updates a specified ``VSNConfiguration`` object with the given parameters.
    /// - Parameters:
    ///   - parameters: Properties to be changed
    ///   - completion: Returns the updated object when successful and an error when not
    ///
    /// - Requires: The following parameters must be provided:
    /// ```
    ///  "id": String
    /// ```
    public func updateConfiguration(withParameters parameters: [String: Any], _ completion: @escaping VSNConfigurationCompletionBlock) {
        VSNRequest<VSNConfiguration>.put(
            with: self,
            endpoint: .configurations,
            parameters: parameters
        ) { reponse, _, error in
            completion(reponse, error)
        }
    }
    
    /// Archives a specified ``VSNConfiguration`` object. This function will not delete the object, but disable it for future purchases.
    /// - Parameters:
    ///   - id: The unique identifier of the ``VSNConfiguration`` object
    ///   - completion: Returns the default ``VSNDeletion`` object when successful and an error if not.
    public func deleteConfiguration(withID id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .configurations,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
}

// MARK: Designers
extension VSNAPIClient {
    /// Returns a ``VSNDesigner`` with the specified unique identifier.
    /// - Parameters:
    ///   - id: The unique identifier of he object
    ///   - completion: Returns a ``VSNDesigner`` object when successful and an error if not
    public func retrieveDesigner(withID id: String, _ completion: @escaping VSNDesignerCompletionBlock) {
        VSNRequest<VSNDesigner>.getWith(
            self,
            endpoint: .designers,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Creates a new ``VSNDesigner`` object
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Returns the newly created object when successful and an error when not
    /// - Requires: The following parameters must be provided:
    ///  ```
    ///   "marketing_title": String
    ///  ```
    public func createDesigner(withParameters parameters: [String: Any], _ completion: @escaping VSNDesignerCompletionBlock) {
        VSNRequest<VSNDesigner>.post(
            with: self,
            endpoint: .designers,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Updates a specified ``VSNDesigner`` object with the given parameters.
    /// - Parameters:
    ///   - parameters: Properties to be changed
    ///   - completion: Returns the updated object when successful and an error when not
    ///
    /// - Requires: The following parameters must be provided:
    /// ```
    ///  "id": String
    /// ```
    public func updateDesigner(withParameters parameters: [String: Any], _ completion: @escaping VSNDesignerCompletionBlock) {
        VSNRequest<VSNDesigner>.put(
            with: self,
            endpoint: .designers,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Deletes the specified ``VSNDesigner`` object.
    /// - Parameters:
    ///   - id: The unique identifier of the ``VSNDesigner`` object
    ///   - completion: Returns the default ``VSNDeletion`` object when successful and an error if not.
    ///
    /// - Warning: Deleting a designer is a final operation and the designer cannot be restored once deleted.
    public func deleteDesigner(withID id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .designers,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
}

// MARK: Designer Career Milestones
extension VSNAPIClient {
    /// Lists all milestones for a specified ``VSNDesigner``
    /// - Parameters:
    ///   - id: The unique identifier of the designer
    ///   - completion: Returns an array of ``VSNDesignerCareerMilestone`` objects when successfull and an error when not.
    ///
    /// - Requires: The following parameters must be provided:
    /// ```
    ///  "id": String
    /// ```
    public func listDesignerCareerMilestones(forDesigner id: String, _ completion: @escaping VSNDesignerCareerMilestonesCompletionBlock) {
        var shared_Milestones = [VSNDesignerCareerMilestone]()
        var shared_lastError: Error? = nil
        let group = DispatchGroup()
        
        group.enter()
        
        VSNRequest<VSNDesignerCareerMilestoneListDeserializer>.getWith(
            self,
            endpoint: .designerCareerMilestones,
            parameters: ["id": id]
        ) { deserializer, _, error in
            DispatchQueue.global(qos: .userInteractive).async(flags: .barrier) {
                // .barrier ensures we're the only thing writing to shared_ vars
                if let error = error {
                    shared_lastError = error
                }
                if let milestones = deserializer?.milestones {
                    shared_Milestones.append(contentsOf: milestones)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(shared_Milestones, shared_lastError)
        }
    }
    
    /// Creates a new milestone for a specified ``VSNDesigner`` object
    /// - Parameters:
    ///   - parameters: The object's properties
    ///   - completion: Returns a ``VSNBoolSuccess`` object. The `success`property will be `true`when successfull and `false`when not.
    ///
    /// - Requires: The following parameters must be provided:
    /// ```
    ///  "designer_id": String,
    ///  "description": String,
    ///  "timestamp": Double,
    ///  "image_url": String
    public func createDesignerCareerMilestone(withParameters parameters: [String: Any], _ completion: @escaping VSNBooleanSuccessBlock) {
        VSNRequest<VSNBoolSuccess>.post(
            with: self,
            endpoint: .designerCareerMilestones,
            parameters: parameters
        ) { response, _, error in
            completion(response, error)
        }
    }
    
    /// Deletes the specified ``VSNDesignerCareerMilestone`` object.
    /// - Parameters:
    ///   - id: The unique identifier of the ``VSNDesignerCareerMilestone`` object
    ///   - completion: Returns the default ``VSNDeletion`` object when successful and an error if not.
    ///
    /// - Warning: Deleting a career milestone is a final operation and the milestone cannot be restored once deleted.
    public func deleteDesignerCareerMilestone(withID id: String, _ completion: @escaping VSNDeleteCompletionBlock) {
        VSNRequest<VSNDeletion>.delete(
            with: self,
            endpoint: .designerCareerMilestones,
            parameters: ["id": id]
        ) { response, _, error in
            completion(response, error)
        }
    }
}

private let APIVersion = "2021-11-21"
private var APIBaseURL: String {
    switch VisionrangerAPI.environment {
    case .live:
        return "https://api.visionranger.com"
    case .test:
        return "https://k9abld85t0.execute-api.eu-central-1.amazonaws.com/dev"
    }
}
