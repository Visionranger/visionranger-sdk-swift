//
//  VSNDesigner.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 09.11.21.
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

public class VSNDesigner: NSObject {
    
    public let id: String?
    
    public var firstName: String?
    
    public var lastName: String?
    
    public var fullName: String?
    
    public var marketingTitle: String?

    public var image: String?
    
    public var allResponseFields: [AnyHashable: Any]
    
    public convenience init(
        id: String,
        marketingTitle: String
    ) {
        self.init(
            id: id,
            firstName: nil,
            lastName: nil,
            fullName: nil,
            marketingTitle: marketingTitle,
            image: nil,
            allResponseFields: [:]
        )
    }
    
    internal init(
        id: String,
        firstName: String?,
        lastName: String?,
        fullName: String?,
        marketingTitle: String,
        image: String?,
        allResponseFields: [AnyHashable: Any]
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.marketingTitle = marketingTitle
        self.image = image
        self.allResponseFields = allResponseFields
    }
    
    convenience override init() {
        self.init(
            id: "",
            firstName: nil,
            lastName: nil,
            fullName: nil,
            marketingTitle: "",
            image: nil,
            allResponseFields: [:]
        )
    }
}

extension VSNDesigner: VSNAPIResponseDecodable {
    
    public class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let dict = response,
        let id = dict["id"] as? String else {
            return nil
        }
        
        return VSNDesigner(
            id: id,
            firstName: dict["first_name"] as? String,
            lastName: dict["last_name"] as? String,
            fullName: dict["full_name"] as? String,
            marketingTitle: dict["marketing_title"] as! String,
            image: dict["image"] as? String,
            allResponseFields: dict
        ) as? Self
    }
}
