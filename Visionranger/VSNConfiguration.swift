//
//  VSNConfiguration.swift
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

public class VSNConfiguration: NSObject {
    
    /// The unique identifier of the product's configuration from the Visionranger API
    public let configID: String?
    /// The global index of the main material, associated to this product configuration
    ///
    /// The main material is defined as the material that covers at least 50% of the visual surface of a product.
    public var material: VSNFurnitureMaterial?
    /// HEX code of the main materials surface color
    public var colorCode: String?
    /// The name of the main materials surface color
    public var color: String?
    /// The unique identifier of the product, this configuration belongs to
    public let productID: String?
    /// Generic string providing information about the main component of the product category
    public var specific: String?
    /// The URL that leads to this product's configuration
    public var modelURL: String?
    /// The URL that leads to a rendered image of the configuration.
    public var imageURL: String?
    /// Provides information about height, length and width of this configuration
    public var dimensions: VSNConfigurationDimensions?
    /// The price of the product in a specified configuration
    public var price: Double?
    /// An estimate of how long it takes from ordering to delivering the product in this configuration
    public var estimatedDelivery: VSNEstimatedDelivery?
    /// Boolean value indicating whether this configuration is visible to the general public
    public var live: Bool?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(
        configID: String,
        productID: String,
        modelURL: String
    ) {
        self.init(
            configID: configID,
            material: .unknown,
            colorCode: "",
            color: "",
            productID: productID,
            specific: "",
            modelURL: modelURL,
            imageURL: "",
            dimensions: nil,
            price: 0,
            estimatedDelivery: .unknown,
            live: false,
            allResponseFields: [:]
        )
    }
    
    internal init(
        configID: String,
        material: VSNFurnitureMaterial?,
        colorCode: String?,
        color: String?,
        productID: String,
        specific: String?,
        modelURL: String,
        imageURL: String,
        dimensions: VSNConfigurationDimensions?,
        price: Double,
        estimatedDelivery: VSNEstimatedDelivery?,
        live: Bool,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.configID = configID
        self.productID = productID
        self.modelURL = modelURL
        self.dimensions = dimensions
        self.price = price
        self.material = material
        self.estimatedDelivery = estimatedDelivery
        self.live = live
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(
            configID: "",
            material: .unknown,
            colorCode: "",
            color: "",
            productID: "",
            specific: "",
            modelURL: "",
            imageURL: "",
            dimensions: nil,
            price: 0,
            estimatedDelivery: .unknown,
            live: false,
            allResponseFields: [:]
        )
    }
}

extension VSNConfiguration: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let configID = dict["id"] as? String,
        let productID = dict["product_id"] as? String
        else {
            return nil
        }
        
        let dimensions: VSNConfigurationDimensions?
        var material: VSNFurnitureMaterial = .unknown
        var delivery: VSNEstimatedDelivery = .unknown
        
        if let dimensionsDict = dict["dimensions"] as? [AnyHashable: Any],
           let details = VSNConfigurationDimensions.decodedObject(fromAPIResponse: dimensionsDict) {
            if let height = dict["height"] as? Double {
                details.height = height
            }
            if let length = dict["depth"] as? Double {
                details.length = length
            }
            if let width = dict["width"] as? Double {
                details.width = width
            }
            dimensions = details
        } else {
            dimensions = nil
        }
        if let index = dict["material"] as? Int {
            material = VSNFurnitureMaterial(rawValue: index)!
        }
        if let index = dict["delivery_index"] as? Int {
            delivery = VSNEstimatedDelivery(rawValue: index)!
        }
        
        return VSNConfiguration(
            configID: configID,
            material: material,
            colorCode: dict["color_code"] as? String,
            color: dict["color"] as? String,
            productID: productID,
            specific: dict["category_specific"] as? String,
            modelURL: dict["model_url"] as! String,
            imageURL: dict["image_url"] as! String,
            dimensions: dimensions,
            price: dict["price"] as! Double,
            estimatedDelivery: delivery,
            live: dict["live"] as! Bool,
            allResponseFields: dict
        ) as? Self
    }
}
