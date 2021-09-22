//
//  VSNConfiguration.swift
//  VSNConfiguration
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VSNProductConfiguration: NSObject {
    
    /// The unique identifier of a product's configuration.
    @objc public var configID: String
    
    /// The stripe ID of the configration's price (e.g. `price_1234`)
    ///
    ///
    /// The price retrieved from this ID is a base reference provided by the manufacturer itself.
    /// To learn more about how prices are generated, visit [Dynamic Priced](https://www.visionranger.com/dynamic-prices).
    /// The added costs for this product configuration can be retrieved from the `dynamicRegionPrice` variable.
    @objc public var priceID: String
    
    /// This value is added to the base value retrieved from the `priceID`.
    @objc public var dynamicRegionPrice: Double
    
    /// Initialize a product configuration object with the provided values.
    /// - Parameters:
    ///   - configID: The unique ID of the product configuration
    ///   - priceID: The unique ID of the price object retrieved from stripe
    ///   - dynamicRegionPrice: Added amount specific to the customer's shipping address
    internal init(configID: String, priceID: String, dynamicRegionPrice: Double) {
        self.configID = configID
        self.priceID = priceID
        self.dynamicRegionPrice = dynamicRegionPrice
        super.init()
    }
}
