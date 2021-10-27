//
//  VSNConfigurationOrderDetails.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 25.09.21.
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

public class VSNConfigurationOrderDetails: NSObject {
    
    /// The average time range in days, that this product configuration requires from ordering to delivery.
    /// This value represents the index of `VSNProductDeliveryRange
    public var estimatedDelivery: VSNEstimatedDelivery?
    
    /// The weight of the product configuration, measured in kilogramm
    public var weight: Double?
    
    /// An array of Doubles, defined as `[length, width, height]`
    public var dimensions: VSNConfigurationDimensions?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(price: Double, weight: Double, dimensions: VSNConfigurationDimensions) {
        self.init(
            weight: weight,
            estimatedDelivery: nil,
            dimensions: dimensions,
            allResponseFields: [:]
        )
    }
    
    internal init(
        weight: Double,
        estimatedDelivery: VSNEstimatedDelivery?,
        dimensions: VSNConfigurationDimensions?,
        allResponseFields: [AnyHashable : Any]
    ) {
        self.weight = weight
        self.estimatedDelivery = estimatedDelivery
        self.dimensions = dimensions
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(weight: 0, estimatedDelivery: nil, dimensions: nil, allResponseFields: [:])
    }
}

extension VSNConfigurationOrderDetails: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response else {
            return nil
        }
        
        let dimensionsObject: VSNConfigurationDimensions?
        if let dimensionsDict = dict["dimensions"] as? [AnyHashable : Any],
           let dimensions = VSNConfigurationDimensions.decodedObject(fromAPIResponse: dimensionsDict) {
            dimensions.length = dimensionsDict["length"] as? Double
            dimensions.height = dimensionsDict["height"] as? Double
            dimensions.width = dimensionsDict["width"] as? Double
            dimensionsObject = dimensions
        } else {
            dimensionsObject = nil
        }
        let weight = dict["weight"] as? Double ?? 0
        let estimatedDelivery = dict["estimated_delivery_index"] as? VSNEstimatedDelivery
        
        return VSNConfigurationOrderDetails(
            weight: weight,
            estimatedDelivery: estimatedDelivery,
            dimensions: dimensionsObject,
            allResponseFields: dict
        ) as? Self
    }
}
