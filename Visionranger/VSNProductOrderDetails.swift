//
//  VSNProductOrderDetails.swift
//  VSNProductOrderDetails
//
//  Created by Colin Tessarzick on 25.09.21.
//

import Foundation

public class VSNProductOrderDetails: NSObject {
    
    /// The price of the product in a specified configuration
    public var price: Double?
    
    /// The average time range in days, that this product configuration requires from ordering to delivery.
    /// This value represents the index of `VSNProductDeliveryRange
    public var estimatedDelivery: VSNProductDeliveryRange?
    
    /// The weight of the product configuration, measured in kilogramm
    public var weight: Double?
    
    /// A 3 dimensional array of Doubles, defined as `[length, width, height]`
    public var dimensions: VSNProductDimensions?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(price: Double, weight: Double, dimensions: VSNProductDimensions) {
        self.init(
            price: price,
            weight: weight,
            estimatedDelivery: nil,
            dimensions: dimensions,
            allResponseFields: [:]
        )
    }
    
    internal init(
        price: Double,
        weight: Double,
        estimatedDelivery: VSNProductDeliveryRange?,
        dimensions: VSNProductDimensions?,
        allResponseFields: [AnyHashable : Any]
    ) {
        self.price = price
        self.weight = weight
        self.estimatedDelivery = estimatedDelivery
        self.dimensions = dimensions
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(price: 0, weight: 0, estimatedDelivery: nil, dimensions: nil, allResponseFields: [:])
    }
}

extension VSNProductOrderDetails: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response else {
            return nil
        }
        
        let dimensionsObject: VSNProductDimensions?
        if let dimensionsDict = dict["dimensions"] as? [AnyHashable : Any],
           let dimensions = VSNProductDimensions.decodedObject(fromAPIResponse: dimensionsDict) {
            dimensions.length = dimensionsDict["length"] as? Double
            dimensions.height = dimensionsDict["height"] as? Double
            dimensions.width = dimensionsDict["width"] as? Double
            dimensionsObject = dimensions
        } else {
            dimensionsObject = nil
        }
        let price = dict["price"] as? Double ?? 0
        let weight = dict["weight"] as? Double ?? 0
        let estimatedDelivery = dict["estimated_delivery_index"] as? VSNProductDeliveryRange
        
        return VSNProductOrderDetails(
            price: price,
            weight: weight,
            estimatedDelivery: estimatedDelivery,
            dimensions: dimensionsObject,
            allResponseFields: dict
        ) as? Self
    }
}
