//
//  VSNAnnouncement.swift
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

public class VSNAnnouncement: NSObject {
    
    /// The unique identifier of the object
    public let id: String?
    /// The title of the announcement. Max character length is 100.
    public var title: String?
    /// The content of the announcement
    public var message: String?
    /// The text to be displayed after a given illustrative image
    public var appendix: String?
    /// The text to be displayed inside modals or other small boxes
    public var shortMessage: String?
    /// The objects main image. Will be displayed on top of all
    public var thumbnail: String?
    /// An image that will be displayed between the main text and the appending text
    public var image: String?
    /// A set of filters to be applied to a given collection of products
    public var collectionFilters: VSNCollectionFilter?
    
    public var allResponseFields: [AnyHashable : Any]
    
    public convenience init(
        id: String,
        title: String,
        message: String,
        shortMessage: String,
        thumbnail: String,
        collection_filters: VSNCollectionFilter
    ) {
        self.init(
            id: id,
            title: title,
            message: message,
            appendix: "",
            shortMessage: shortMessage,
            thumbnail: thumbnail,
            image: "",
            collection_filters: collection_filters,
            allResponseFields: [:]
        )
    }
    
    internal init(
        id: String,
        title: String,
        message: String,
        appendix: String?,
        shortMessage: String,
        thumbnail: String,
        image: String?,
        collection_filters: VSNCollectionFilter?,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.appendix = appendix
        self.shortMessage = shortMessage
        self.thumbnail = thumbnail
        self.image = image
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(
            id: "",
            title: "",
            message: "",
            appendix: "",
            shortMessage: "",
            thumbnail: "",
            image: "",
            collection_filters: nil,
            allResponseFields: [:]
        )
    }
}

extension VSNAnnouncement: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let id = dict["id"] as? String else {
            return nil
        }
        
        let filters: VSNCollectionFilter?
        
        if let filterObject = dict["collection_filters"] as? [AnyHashable: Any],
           let filter = VSNCollectionFilter.decodedObject(fromAPIResponse: filterObject) {
            if let manufacturer = dict["manufacturer"] as? String {
                filter.manufacturer = manufacturer
            }
            if let type = dict["type"] as? Int {
                filter.type = VSNFurnitureType(rawValue: type)
            }
            if let category = dict["category"] as? Int {
                filter.category = VSNFurnitureCategory(rawValue: category)
            }
            if let designer = dict["designer"] as? String {
                filter.designer = designer
            }
            if let designStyle = dict["design_style"] as? Int {
                filter.designStyle = VSNDesignStyle(rawValue: designStyle)
            }
            if let room = dict["room"] as? Int {
                filter.room = VSNRoom(rawValue: room)
            }
            if let houseArea = dict["house_area"] as? Int {
                filter.houseArea = VSNHouseArea(rawValue: houseArea)
            }
            if let creationDate = dict["created_at"] as? Double {
                filter.creationDate = Date(timeIntervalSince1970: creationDate)
            }
            filters = filter
        } else {
            filters = nil
        }
        
        return VSNAnnouncement(
            id: id,
            title: dict["title"] as! String,
            message: dict["description"] as! String,
            appendix: dict["appendix"] as? String,
            shortMessage: dict["short_description"] as! String,
            thumbnail: dict["thumbnail"] as! String,
            image: dict["image"] as? String,
            collection_filters: filters,
            allResponseFields: dict
        ) as? Self
    }
}
