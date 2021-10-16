//
//  VSNCollectionFilter.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 12.10.21.
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

/// A set of filters to be applied to a given collection of objects.
public class VSNCollectionFilter: NSObject {
    
    /// The unique identifier of the manufacturer
    public var manufacturer: String?
    /// The index of the furniture type
    public var type: VSNFurnitureType?
    /// The index of the furniture category
    public var category: VSNFurnitureCategory?
    /// The name of the designer
    public var designer: String?
    /// The index of the design style
    public var designStyle: VSNDesignStyle?
    /// The index of the room
    public var room: VSNRoom?
    /// The index of the house area
    public var houseArea: VSNHouseArea?
    /// Time at which the product was created. Measured in seconds since the Unix epoch.
    public var creationDate: Date?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience override init() {
        self.init(
            manufacturer: nil,
            type: .unknown,
            category: .unknown,
            designer: nil,
            designStyle: .unknown,
            room: .unknown,
            houseArea: .unknown,
            creationDate: nil,
            allResponseFields: [:]
        )
    }
    
    internal init(
        manufacturer: String?,
        type: VSNFurnitureType?,
        category: VSNFurnitureCategory?,
        designer: String?,
        designStyle: VSNDesignStyle?,
        room: VSNRoom?,
        houseArea: VSNHouseArea?,
        creationDate: Date?,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.manufacturer = manufacturer
        self.type = type
        self.category = category
        self.designer = designer
        self.designStyle = designStyle
        self.room = room
        self.houseArea = houseArea
        self.creationDate = creationDate
        self.allResponseFields = allResponseFields
    }
}

extension VSNCollectionFilter: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response else {
            return nil
        }
        
        let filters = VSNCollectionFilter()
        filters.allResponseFields = dict
        // All properties are nullable
        if let manufacturer = dict["manufacturer"] as? String {
            filters.manufacturer = manufacturer
        }
        if let type = dict["type"] as? Int {
            filters.type = VSNFurnitureType(rawValue: type)
        }
        if let category = dict["category"] as? Int {
            filters.category = VSNFurnitureCategory(rawValue: category)
        }
        if let designer = dict["designer"] as? String {
            filters.designer = designer
        }
        if let designStyle = dict["design_style"] as? Int {
            filters.designStyle = VSNDesignStyle(rawValue: designStyle)
        }
        if let room = dict["room"] as? Int {
            filters.room = VSNRoom(rawValue: room)
        }
        if let houseArea = dict["house_area"] as? Int {
            filters.houseArea = VSNHouseArea(rawValue: houseArea)
        }
        if let creationDate = dict["created_at"] as? Double {
            filters.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        return filters as? Self
    }
}
