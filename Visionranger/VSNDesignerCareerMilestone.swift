//
//  VSNDesignerCareerMilestone.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 21.11.21.
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

public class VSNDesignerCareerMilestone: NSObject {
    
    public let id: String?
    public var content: String?
    public var image: String?
    public var timestamp: Double?
    public var designerID: String?
    
    public var allResponseFields: [AnyHashable: Any]
    
    internal init(
        id: String,
        content: String,
        image: String,
        timestamp: Double,
        designerID: String,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.id = id
        self.content = content
        self.image = image
        self.timestamp = timestamp
        self.designerID = designerID
        self.allResponseFields = allResponseFields
    }
    
    convenience override public init() {
        self.init(
            id: "",
            content: "",
            image: "",
            timestamp: 0,
            designerID: "",
            allResponseFields: [:]
        )
    }
}

extension VSNDesignerCareerMilestone: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let id = dict["id"] as? String,
        let designerID = dict["designer"] as? String else {
            return nil
        }
        
        return VSNDesignerCareerMilestone(
            id: id,
            content: dict["description"] as! String,
            image: dict["image_url"] as! String,
            timestamp: dict["timestamp"] as! Double,
            designerID: designerID,
            allResponseFields: dict
        ) as? Self
    }
}
