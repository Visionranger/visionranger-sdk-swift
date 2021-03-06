//
//  VSNProduct.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 22.09.21.
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

public class VSNProduct: NSObject {
    
    public let productID: String?
    
    public var name: String?
    
    public var catalogization: VSNProductCatalogization?
    
    public var imageURL: String?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(id: String, name: String) {
        self.init(
            productID: id,
            name: name,
            catalogization: nil,
            imageURL: nil,
            allResponseFields: [:]
        )
    }
    
    internal init(
        productID: String,
        name: String,
        catalogization: VSNProductCatalogization?,
        imageURL: String?,
        allResponseFields: [AnyHashable : Any]
    ) {
        self.productID = productID
        self.name = name
        self.catalogization = catalogization
        self.imageURL = imageURL
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(
            productID: "",
            name: "",
            catalogization: nil,
            imageURL: nil,
            allResponseFields: [:]
        )
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
            if let room = dict["room"] as? Int {
                catalogDetails.room = VSNRoom(rawValue: room)
            }
            if let houseArea = dict["house_area"] as? Int {
                catalogDetails.houseArea = VSNHouseArea(rawValue: houseArea)
            }
            if let designStyle = dict["design_style"] as? Int {
                catalogDetails.designStyle = VSNDesignStyle(rawValue: designStyle)
            }
            if let type = dict["category"] as? Int {
                catalogDetails.category = VSNFurnitureType(rawValue: type)
            }
            if let category = dict["sub_category"] as? Int {
                catalogDetails.subCategory = VSNFurnitureCategory(rawValue: category)
            }
            catalogization = catalogDetails
        } else {
            catalogization = nil
        }
        
        return VSNProduct(
            productID: productID,
            name: name,
            catalogization: catalogization,
            imageURL: dict["preview_image_url"] as? String,
            allResponseFields: dict
        ) as? Self
    }
}
