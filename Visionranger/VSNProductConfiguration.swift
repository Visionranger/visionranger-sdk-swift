//
//  VSNProductConfiguration.swift
//  VSNProductConfiguration
//
//  Created by Colin Tessarzick on 23.09.21.
//

import Foundation

public class VSNProductConfiguration: NSObject {
    
    /// The unique identifier of the product's configuration from the Visionranger API
    public let configID: String?
    
    /// The unique identifier of the product, this configuration belongs to
    public let associatedProductID: String?
    
    /// The price of the product in this configuration
    public var price: Double?
    
    /// The global index of the main material, associated to this product configuration
    ///
    /// The main material is defined as the material that covers at least 50% of the visual surface of a product.
    public var material: Int?
    
    /// The color of the main material, associated to this product configuration
    public var color: String?
    
    /// The URL that leads to this product's configuration
    public var modelURL: String?
    
    /// The average time range in days, that this product configuration requires from ordering to delivery.
    /// This value represents the index of `VSNProductDeliveryRange
    public var estimatedDelivery: Int?
    
    /// A 3 dimensional array of Doubles, defined as `[length, width, height]`
    public var dimensions: VSNProductDimensions?
    
    /// The weight of the product configuration, measured in kilogramm
    public var weight: Double?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(configID: String, associatedProductID: String, modelURL: String) {
        self.init(
            configID: configID,
            associatedProductID: associatedProductID,
            material: 0,
            modelURL: modelURL,
            dimensions: VSNProductDimensions(),
            weight: 0,
            allResponseFields: [:]
        )
    }
    
    internal init(
        configID: String,
        associatedProductID: String,
        material: Int,
        modelURL: String,
        dimensions: VSNProductDimensions?,
        weight: Double,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.configID = configID
        self.associatedProductID = associatedProductID
        self.material = material
        self.modelURL = modelURL
        self.dimensions = dimensions
        self.weight = weight
        self.allResponseFields = allResponseFields
        super.init()
    }
    
    convenience override init() {
        self.init(
            configID: "",
            associatedProductID: "",
            material: 0,
            modelURL: "",
            dimensions: VSNProductDimensions(),
            weight: 0,
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
        
        let productDimensions: VSNProductDimensions?
        
        if let dimensionsDict = dict["dimensions"] as? [AnyHashable: Any],
           let dimensions = VSNProductDimensions.decodedObject(fromAPIResponse: dimensionsDict) {
            dimensions.length = dimensionsDict["length"] as? Double
            dimensions.width = dimensionsDict["width"] as? Double
            dimensions.height = dimensionsDict["height"] as? Double
            productDimensions = dimensions
        } else {
            productDimensions = nil
        }
        
        return VSNProductConfiguration(
            configID: configID,
            associatedProductID: productID,
            material: dict["material"] as! Int,
            modelURL: dict["model_url"] as! String,
            dimensions: productDimensions,
            weight: dict["weight"] as! Double,
            allResponseFields: dict
        ) as? Self
    }
}
