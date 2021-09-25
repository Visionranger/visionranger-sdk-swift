//
//  VSNProductInteriorDetails.swift
//  VSNProductInteriorDetails
//
//  Created by Colin Tessarzick on 25.09.21.
//

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
