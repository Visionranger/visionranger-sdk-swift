//
//  VSNProductInteriorDetails.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 25.09.21.
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

public class VSNProductCatalogization: NSObject {
    
    /// The index of the associated room from the Visionranger API
    public var room: Int?
    
    /// The index of the preferred area of the house from the Visionranger API
    public var houseArea: Int?
    
    /// The index of the associated interior design style from the Visionranger API
    public var designStyle: Int?
    
    /// The index of the associated category from the Visionranger API
    public var category: Int?
    
    /// The index of the associated sub-category from the Visionranger API
    public var subCategory: Int?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(designStyle: Int, category: Int, subCategory: Int) {
        self.init(room: 0, houseArea: 0, designStyle: designStyle, category: category, subCategory: subCategory, allResponsefields: [:])
    }
    
    internal init(room: Int, houseArea: Int, designStyle: Int, category: Int, subCategory: Int, allResponsefields: [AnyHashable : Any]) {
        self.room = room
        self.houseArea = houseArea
        self.designStyle = designStyle
        self.category = category
        self.subCategory = subCategory
        self.allResponseFields = allResponsefields
    }
    
    convenience override init() {
        self.init(room: 0, houseArea: 0, designStyle: 0, category: 0, subCategory: 0, allResponsefields: [:])
    }
}

extension VSNProductCatalogization: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response else {
            return nil
        }
        
        let details = VSNProductCatalogization()
        details.allResponseFields = dict
        // All properties are nullable
        details.room = dict["room"] as? Int
        details.houseArea = dict["house_area"] as? Int
        details.designStyle = dict["design_style"] as? Int
        details.category = dict["category"] as? Int
        details.subCategory = dict["sub_category"] as? Int
        
        return details as? Self
    }
}