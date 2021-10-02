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
    public var room: VSNRoom?
    
    /// The index of the preferred area of the house from the Visionranger API
    public var houseArea: VSNHouseArea?
    
    /// The index of the associated interior design style from the Visionranger API
    public var designStyle: VSNDesignStyle?
    
    /// The index of the associated category from the Visionranger API
    public var category: VSNFurnitureType?
    
    /// The index of the associated sub-category from the Visionranger API
    public var subCategory: VSNFurnitureCategory?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(
        designStyle: VSNDesignStyle,
        category: VSNFurnitureType,
        subCategory: VSNFurnitureCategory
    ) {
        self.init(
            room: VSNRoom.unknown,
            houseArea: VSNHouseArea.unknown,
            designStyle: designStyle,
            category: category,
            subCategory: subCategory,
            allResponsefields: [:]
        )
    }
    
    internal init(
        room: VSNRoom,
        houseArea: VSNHouseArea,
        designStyle: VSNDesignStyle,
        category: VSNFurnitureType,
        subCategory: VSNFurnitureCategory,
        allResponsefields: [AnyHashable : Any]
    ) {
        self.room = room
        self.houseArea = houseArea
        self.designStyle = designStyle
        self.category = category
        self.subCategory = subCategory
        self.allResponseFields = allResponsefields
    }
    
    convenience override init() {
        self.init(
            room: VSNRoom.unknown,
            houseArea: VSNHouseArea.unknown,
            designStyle: VSNDesignStyle.unknown,
            category: VSNFurnitureType.unknown,
            subCategory: VSNFurnitureCategory.unknown,
            allResponsefields: [:]
        )
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
        if let room = dict["room"] as? Int {
            details.room = VSNRoom(rawValue: room)
        }
        if let houseArea = dict["house_area"] as? Int {
            details.houseArea = VSNHouseArea(rawValue: houseArea)
        }
        if let designStyle = dict["design_style"] as? Int {
            details.designStyle = VSNDesignStyle(rawValue: designStyle)
        }
        if let type = dict["category"] as? Int {
            details.category = VSNFurnitureType(rawValue: type)
        }
        if let category = dict["sub_category"] as? Int {
            details.subCategory = VSNFurnitureCategory(rawValue: category)
        }
        
        return details as? Self
    }
}
