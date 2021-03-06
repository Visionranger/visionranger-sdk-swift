//
//  VSNConfigurationListDeserializer.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 23.10.21.
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

class VSNConfigurationListDeserializer: NSObject, VSNAPIResponseDecodable {
    private(set) var configurations: [VSNConfiguration]?
    private(set) var allResponseFields: [AnyHashable : Any] = [:]
    
    override required init() {
        super.init()
    }
    
    class func decodedObject(fromAPIResponse response: [AnyHashable : Any]?) -> Self? {
        guard let response = response else {
            return nil
        }
        let dict = (response as NSDictionary).vsn_dictionaryByRemovingNulls() as NSDictionary
        
        guard let data = dict.vsn_array(forKey: "data") as? [[AnyHashable: Any]] else {
            return nil
        }
        let configurationsDeserializer = self.init()
        var configurations: [VSNConfiguration] = []
        for configJSON in data {
            let config = VSNConfiguration.decodedObject(fromAPIResponse: configJSON)
            if let config = config {
                configurations.append(config)
            }
        }
        configurationsDeserializer.configurations = configurations
        return configurationsDeserializer
    }
}
