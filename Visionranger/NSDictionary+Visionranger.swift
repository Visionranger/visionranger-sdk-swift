//
//  NSDictionary+Visionranger.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 30.09.21.
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

extension NSDictionary {
    func vsn_dictionaryByRemovingNulls() -> [AnyHashable: Any] {
        var result = [AnyHashable: Any]()

        (self as NSDictionary).enumerateKeysAndObjects({ key, obj, _ in
            guard let key = key as? AnyHashable else {
                assertionFailure()
                return
            }
            if let obj = obj as? [Any] {
                // Save array after removing any null values
                let vsn = obj.vsn_arrayByRemovingNulls()
                result[key] = vsn
            } else if let obj = obj as? NSDictionary {
                // Save dictionary after removing any null values
                let vsn = obj.vsn_dictionaryByRemovingNulls() as NSDictionary
                result[key] = vsn
            } else if obj is NSNull {
                // Skip null value
            } else {
                // Save other value
                result[key] = obj
            }
        })

        // Make immutable copy
        return result
    }
    
    func vsn_dictionaryByRemovingNonStrings() -> [String: String] {
        var result: [String: String] = [:]

        (self as NSDictionary).enumerateKeysAndObjects({ key, obj, _ in
            if let key = key as? String, let obj = obj as? String {
                // Save valid key/value pair
                result[key] = obj
            }
        })

        // Make immutable copy
        return result
    }
    
    // Getters
    func vsn_array(forKey key: String) -> [Any]? {
        let value = self[key]
        if value != nil {
            return value as? [Any]
        }
        return nil
    }
    
    func vsn_bool(forKey key: String, or defaultValue: Bool) -> Bool {
        let value = self[key]
        if value != nil {
            if let value = value as? NSNumber {
                return value.boolValue
            }
            if value is NSString {
                let string = (value as? String)?.lowercased()
                // boolValue on NSString is true for "Y", "y", "T", "t", or 1-9
                if (string == "true") || (string as NSString?)?.boolValue ?? false {
                    return true
                } else {
                    return false
                }
            }
        }
        return defaultValue
    }
    
    func vsn_date(forKey key: String) -> Date? {
        let value = self[key]
        if let value = value as? NSNumber {
            let timeInterval = value.doubleValue
            return Date(timeIntervalSince1970: TimeInterval(timeInterval))
        } else if let value = value as? NSString {
            let timeInterval = value.doubleValue
            return Date(timeIntervalSince1970: TimeInterval(timeInterval))
        }
        return nil
    }

    func vsn_dictionary(forKey key: String) -> [AnyHashable: Any]? {
        let value = self[key]
        if value != nil && (value is [AnyHashable: Any]) {
            return value as? [AnyHashable: Any]
        }
        return nil
    }
    
    func vsn_int(forKey key: String, or defaultValue: Int) -> Int {
        let value = self[key]
        if let value = value as? NSNumber {
            return value.intValue
        } else if let value = value as? NSString {
            return Int(value.intValue)
        }
        return defaultValue
    }

    func vsn_number(forKey key: String) -> NSNumber? {
        return self[key] as? NSNumber
    }

    func vsn_string(forKey key: String) -> String? {
        let value = self[key]
        if value != nil && (value is NSString) {
            return value as? String
        }
        return nil
    }
    
    func vsn_url(forKey key: String) -> URL? {
        let value = self[key]
        if value != nil && (value is NSString) && ((value as? String)?.count ?? 0) > 0 {
            return URL(string: value as? String ?? "")
        }
        return nil
    }
}
