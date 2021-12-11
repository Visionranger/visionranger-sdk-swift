//
//  VSNProductListConfigurationPreview.swift
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

public class VSNProductListConfigurationPreview: NSObject {
    
    public let configID: String?
    
    public var material: VSNFurnitureMaterial?
    
    public var price: Double?
    
    public var imageURL: String?
    
    public var materialImageURL: String?
    
    public var context: String?
    
    public var color: String?
    
    public var allResponseFields: [AnyHashable: Any]
    
    public convenience init(id: String, price: Double, imageURL: String) {
        self.init(
            configID: id,
            material: .unknown,
            price: price,
            imageURL: imageURL,
            materialImageURL: "",
            context: "",
            color: "",
            allResponseFields: [:]
        )
    }
    
    internal init(
        configID: String,
        material: VSNFurnitureMaterial,
        price: Double,
        imageURL: String,
        materialImageURL: String,
        context: String,
        color: String,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.configID = configID
        self.material = material
        self.price = price
        self.imageURL = imageURL
        self.materialImageURL = materialImageURL
        self.context = context
        self.color = color
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(
            configID: "",
            material: .unknown,
            price: 0,
            imageURL: "",
            materialImageURL: "",
            context: "",
            color: "",
            allResponseFields: [:]
        )
    }
}

extension VSNProductListConfigurationPreview: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response else {
            return nil
        }
        
        let details = VSNProductListConfigurationPreview()
        
        details.allResponseFields = dict
        
        if let material = dict["material"] as? Int {
            details.material = VSNFurnitureMaterial(rawValue: material)
        }
        if let price = dict["price"] as? Double {
            details.price = price
        }
        if let url = dict["image"] as? String {
            details.imageURL = url
        }
        if let url = dict["material_image"] as? String {
            details.materialImageURL = url
        }
        if let context = dict["description"] as? String {
            details.context = context
        }
        if let color = dict["color"] as? String {
            details.color = color
        }
        
        return details as? Self
    }
}
