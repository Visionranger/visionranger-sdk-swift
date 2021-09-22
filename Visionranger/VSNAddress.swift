//
//  VSNAddress.swift
//  VSNAddress
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

public class VSNAddress: NSObject {
    
    /// The customer's full name (e.g. "Steven Yang")
    @objc public var name: String?
    
    /// The first line of the customer's street address (e.g. Musterstrasse 123)
    @objc public var line1: String?
    
    /// The second line of the customer's street address (e.g. Penthouse)
    @objc public var line2: String?
    
    /// The city in which the customer resides (e.g. Frankfurt)
    @objc public var city: String?
    
    /// The state in which the customer resides (e.g. Hesse)
    @objc public var state: String?
    
    /// The postal code of the customer's address (e.g. 12345)
    @objc public var postalCode: String?
    
    /// The ISO country code in which the customer resides (e.g. "DE")
    @objc public var country: String?
    
    /// The phone number of the address (e.g. 015249167583)
    @objc public var phone: String?
    
    /// The email of the customer address (e.g. steven.yang@domain.com)
    @objc public var email: String?
    
    @objc public var additionalAPIParameters: [AnyHashable: Any] = [:]
}
