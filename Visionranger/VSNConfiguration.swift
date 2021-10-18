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
    
    /// The unique identifier of the product, this configuration belongs to
    public let productID: String?
    
    public let manufacturerID: String?
    
    public var live: Bool?
    
    public var SKU: String?
    
    /// The URL that leads to this product's configuration
    public var modelURL: String?
    
    public var dimensions: VSNConfigurationDimensions?
    
    /// The price of the product in a specified configuration
    public var price: Double?
    
    /// The global index of the main material, associated to this product configuration
    ///
    /// The main material is defined as the material that covers at least 50% of the visual surface of a product.
    public var material: VSNFurnitureMaterial?
    
    /// The unique identifier of the finish object, associated with this configuration
    public var finish: String?
    
    public var estimatedDelivery: VSNEstimatedDelivery?
    
    public var packageDetails: [AnyHashable: Any]?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(
        configID: String,
        productID: String,
        manufacturerID: String,
        modelURL: String
    ) {
        self.init(
            configID: configID,
            productID: productID,
            manufacturerID: manufacturerID,
            live: false,
            sku: "",
            modelURL: modelURL,
            dimensions: nil,
            price: 0,
            material: .unknown,
            finish: "",
            estimatedDelivery: .unknown,
            packageDetails: nil,
            allResponseFields: [:]
        )
    }
    
    internal init(
        configID: String,
        productID: String,
        manufacturerID: String,
        live: Bool,
        sku: String,
        modelURL: String,
        dimensions: VSNConfigurationDimensions?,
        price: Double,
        material: VSNFurnitureMaterial,
        finish: String,
        estimatedDelivery: VSNEstimatedDelivery,
        packageDetails: [AnyHashable: Any]?,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.configID = configID
        self.productID = productID
        self.manufacturerID = manufacturerID
        self.live = live
        self.SKU = sku
        self.modelURL = modelURL
        self.dimensions = dimensions
        self.price = price
        self.material = material
        self.finish = finish
        self.estimatedDelivery = estimatedDelivery
        self.packageDetails = packageDetails
        self.allResponseFields = allResponseFields
        super.init()
    }
    
    convenience override init() {
        self.init(
            configID: "",
            productID: "",
            manufacturerID: "",
            live: false,
            sku: "",
            modelURL: "",
            dimensions: nil,
            price: 0,
            material: .unknown,
            finish: "",
            estimatedDelivery: .unknown,
            packageDetails: nil,
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
        
        let orderDetails: VSNConfigurationOrderDetails?
        
        if let orderDict = dict["order_details"] as? [AnyHashable : Any],
           let order = VSNConfigurationOrderDetails.decodedObject(fromAPIResponse: orderDict) {
            order.price = orderDict["price"] as? Double
            order.weight = orderDict["weight"] as? Double
            order.estimatedDelivery = orderDict["estimated_delivery_index"] as? VSNEstimatedDelivery
            order.dimensions = orderDict["dimensions"] as? VSNConfigurationDimensions
            order.allResponseFields = orderDict
            orderDetails = order
        } else {
            orderDetails = nil
        }
        
        return VSNConfiguration(
            configID: configID,
            associatedProductID: productID,
            material: dict["material"] as! Int,
            modelURL: dict["model_url"] as! String,
            orderDetails: orderDetails,
            allResponseFields: dict
        ) as? Self
    }
}
