//
//  Product.swift
//  Product
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

/// `Product` objects contain information about a specific product.
/// You can use this object to show granular details about a product.
public struct Product: Codable {
    /// Name of the product.
    let name: String
    /// The unique identifier of the designer.
    let designer: String
    /// The unique identifier of the manufacturer.
    let manufacturer: String
    /// The base price of the product, that the manufacturer provided.
    let price: Double
    /// The category that the product is associated to.
    let category: String
    /// The subcategory that the product is associated to.
    let sub_category: String
    /// An object containing information about the environments where the product can be used.
    let available_environments: VSNProductAvailableEnvironmentSettings
}

struct VSNProductAvailableEnvironmentSettings: Codable {
    /// A boolean value indicating whether the product is available in test mode.
    let test_mode: Bool
    /// A boolean value indicating whether the product is available in live mode.
    /// A product can only be purchased if this value is `true`
    let live_mode: Bool
}
