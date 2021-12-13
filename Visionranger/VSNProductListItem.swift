//
//  VSNProductListItem.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 11.12.21.
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
//

import Foundation

public class VSNProductListItem: NSObject {
    
    public let productID: String?
    
    public var name: String?
    
    public var subCategory: VSNFurnitureCategory?
    
    public var configurationPreviewSet: [VSNProductListConfigurationPreview]?
    
    public var allResponseFields: [AnyHashable: Any]
    
    public convenience init(id: String, name: String) {
        self.init(
            productID: id,
            name: name,
            subCategory: .unknown,
            configurationPreviewSet: nil,
            allResponseFields: [:]
        )
    }
    
    internal init(
        productID: String,
        name: String,
        subCategory: VSNFurnitureCategory?,
        configurationPreviewSet: [VSNProductListConfigurationPreview]?,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.productID = productID
        self.name = name
        self.subCategory = subCategory
        self.configurationPreviewSet = configurationPreviewSet
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(
            productID: "",
            name: "",
            subCategory: .unknown,
            configurationPreviewSet: nil,
            allResponseFields: [:]
        )
    }
}

extension VSNProductListItem: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let productID = dict["id"] as? String,
        let name = dict["name"] as? String,
        let category = dict["category"] as? Int else {
            return nil
        }
        
        var configurationPreviewSet: [VSNProductListConfigurationPreview] = []
        
        if let configurationArray = dict["configurations"] as? NSArray {
            for preview in configurationArray {
                if let configDict = preview as? [AnyHashable: Any],
                   let previewDetails = VSNProductListConfigurationPreview.decodedObject(fromAPIResponse: configDict) {
                    if let material = dict["material"] as? Int {
                        previewDetails.material = VSNFurnitureMaterial(rawValue: material)
                    }
                    if let price = dict["price"] as? Double {
                        previewDetails.price = price
                    }
                    if let url = dict["image"] as? String {
                        previewDetails.imageURL = url
                    }
                    if let url = dict["material_image"] as? String {
                        previewDetails.materialImageURL = url
                    }
                    if let context = configDict["description"] as? String {
                        previewDetails.context = context
                    }
                    if let color = dict["color"] as? String {
                        previewDetails.color = color
                    }
                    configurationPreviewSet.append(previewDetails)
                }
            }
        }
        
        return VSNProductListItem(
            productID: productID,
            name: name,
            subCategory: VSNFurnitureCategory(rawValue: category),
            configurationPreviewSet: configurationPreviewSet,
            allResponseFields: dict
        ) as? Self
    }
}
