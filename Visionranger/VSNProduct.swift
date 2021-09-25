//
//  VSNProduct.swift
//  VSNProduct
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VSNProduct: NSObject {
    
    public var productID: String?
    
    public var name: String?
    
    public var catalogization: VSNProductCatalogization?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(id: String, name: String) {
        self.init(productID: id, name: name, catalogization: nil, allResponseFields: [:])
    }
    
    internal init(productID: String, name: String, catalogization: VSNProductCatalogization?, allResponseFields: [AnyHashable : Any]) {
        self.productID = productID
        self.name = name
        self.catalogization = catalogization
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(productID: "", name: "", catalogization: nil, allResponseFields: [:])
    }
}

extension VSNProduct: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let productID = dict["id"] as? String,
        let name = dict["name"] as? String else {
            return nil
        }
        
        let catalogization: VSNProductCatalogization?
        
        if let catalogDict = dict["catalogization_details"] as? [AnyHashable : Any],
           let catalogDetails = VSNProductCatalogization.decodedObject(fromAPIResponse: catalogDict) {
            catalogDetails.room = catalogDict["room"] as? Int
            catalogDetails.houseArea = catalogDict["house_area"] as? Int
            catalogDetails.designStyle = catalogDict["interior_design_style"] as? Int
            catalogDetails.category = catalogDict["category"] as? Int
            catalogDetails.subCategory = catalogDict["sub_category"] as? Int
            catalogization = catalogDetails
        } else {
            catalogization = nil
        }
        
        return VSNProduct(
            productID: productID,
            name: name,
            catalogization: catalogization,
            allResponseFields: dict
        ) as? Self
    }
}
