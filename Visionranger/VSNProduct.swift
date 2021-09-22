//
//  VSNProduct.swift
//  VSNProduct
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VSNProduct: NSObject {
    
    /// The Visionranger ID of the product, e.g. `prod_1234`
    @objc public let productID: String
    
    @objc public var shippingAddress: VSNAddress?
    
    internal init(productID: String, shippingAddress: VSNAddress) {
        self.productID = productID
        self.shippingAddress = shippingAddress
        super.init()
    }
}
