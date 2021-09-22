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
    
    internal init(productID: String) {
        self.productID = productID
        super.init()
    }
}
