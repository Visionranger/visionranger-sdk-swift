//
//  VSNAppInfo.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 03.12.21.
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

/// Libraries wrapping the Visionranger SDK should use this object to provide information about the library, and set it
/// in on `VSNAPIClient`.  This information is passed to Visionranger so that we can contact you about future issues or critical updates.
public class VSNAppInfo {
    /// Initializes an instance of `VSNAppInfo`.
    /// - Parameters:
    ///   - name:        The name of your library (e.g. "MyAwesomeLibrary").
    ///   - partnerId:   Your Visionranger Partner ID (e.g. "pp_partner_1234"). Required for Visionranger Verified Partners, optional otherwise.
    ///   - version:     The version of your library (e.g. "1.2.34"). Optional.
    ///   - url:         The website for your library (e.g. "https://myawesomelibrary.info"). Optional.
    public init(
        name: String,
        partnerId: String?,
        version: String?,
        url: String?
    ) {
        self.name = name
        self.partnerId = partnerId
        self.version = version
        self.url = url
        self.launchConfiguration = VSNAppLaunchConfiguration.appConfiguration
    }
    
    /// The name of your library (e.g. "MyAwesomeLibrary").
    public private(set) var name: String
    /// Your Stripe Partner ID (e.g. "pp_partner_1234").
    public private(set) var partnerId: String?
    /// The version of your library (e.g. "1.2.34").
    public private(set) var version: String?
    /// The website for your library (e.g. "https://myawesomelibrary.info").
    public private(set) var url: String?
    /// The configuration through which your library is launched from (e.g. App Store, TestFlight or Debug)
    var launchConfiguration: VSNAppConfiguration?
}
