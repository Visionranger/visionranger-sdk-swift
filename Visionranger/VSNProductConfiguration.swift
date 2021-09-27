//
//  VSNProductConfiguration.swift
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

public class VSNProductConfiguration: NSObject {
    
    /// The unique identifier of the product's configuration from the Visionranger API
    public let configID: String?
    
    /// The unique identifier of the product, this configuration belongs to
    public let associatedProductID: String?
    
    /// The global index of the main material, associated to this product configuration
    ///
    /// The main material is defined as the material that covers at least 50% of the visual surface of a product.
    public var material: Int?
    
    /// The color of the main material, associated to this product configuration
    public var color: String?
    
    /// The URL that leads to this product's configuration
    public var modelURL: String?
    
    public var orderDetails: VSNProductOrderDetails?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(configID: String, associatedProductID: String, modelURL: String) {
        self.init(
            configID: configID,
            associatedProductID: associatedProductID,
            material: 0,
            modelURL: modelURL,
            orderDetails: nil,
            allResponseFields: [:]
        )
    }
    
    internal init(
        configID: String,
        associatedProductID: String,
        material: Int,
        modelURL: String,
        orderDetails: VSNProductOrderDetails?,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.configID = configID
        self.associatedProductID = associatedProductID
        self.material = material
        self.modelURL = modelURL
        self.orderDetails = orderDetails
        self.allResponseFields = allResponseFields
        super.init()
    }
    
    convenience override init() {
        self.init(
            configID: "",
            associatedProductID: "",
            material: 0,
            modelURL: "",
            orderDetails: nil,
            allResponseFields: [:]
        )
    }
}

extension VSNProductConfiguration: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let configID = dict["id"] as? String,
        let productID = dict["product_id"] as? String
        else {
            return nil
        }
        
        let orderDetails: VSNProductOrderDetails?
        
        if let orderDict = dict["order_details"] as? [AnyHashable : Any],
           let order = VSNProductOrderDetails.decodedObject(fromAPIResponse: orderDict) {
            order.price = orderDict["price"] as? Double
            order.weight = orderDict["weight"] as? Double
            order.estimatedDelivery = orderDict["estimated_delivery_index"] as? VSNProductDeliveryRange
            order.dimensions = orderDict["dimensions"] as? VSNProductDimensions
            order.allResponseFields = orderDict
            orderDetails = order
        } else {
            orderDetails = nil
        }
        
        return VSNProductConfiguration(
            configID: configID,
            associatedProductID: productID,
            material: dict["material"] as! Int,
            modelURL: dict["model_url"] as! String,
            orderDetails: orderDetails,
            allResponseFields: dict
        ) as? Self
    }
}
