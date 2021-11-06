//
//  BundleLocatorProtocol.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 06.11.21.
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

public protocol BundleLocatorProtocol {
    static var internalClass: AnyClass { get }
    static var bundleName: String { get }
    static var resourcesBundle: Bundle { get }
    #if SWIFT_PACKAGE
    static var spmResourcesBundle: Bundle { get }
    #endif
}

public extension BundleLocatorProtocol {
    
    /// Computes the bundle to fetch resources from.
    ///
    /// - Note: This should never be called directly. Instead, call `resourcesBundle`.
    ///
    /// - Description:
    ///     Places to check:
    ///     1. Swift Package Manager bundle
    ///     2. Stripe.bundle (for manual static installations and framework-less Cocoapods)
    ///     3. Stripe.framework/Stripe.bundle (for framework-based Cocoapods)
    ///     4. Stripe.framework (for Carthage, manual dynamic installations)
    ///     5. main bundle (for people dragging all our files into their project)
    static func computeResourcesBundle() -> Bundle {
        var ourBundle: Bundle?
        
        #if SWIFT_PACKAGE
        ourBundle = spmResourcesBundle
        #endif

        if ourBundle == nil {
            ourBundle = Bundle(path: "\(bundleName).bundle")
        }

        if ourBundle == nil {
            // This might be the same as the previous check if not using a dynamic framework
            if let path = Bundle(for: internalClass).path(
                forResource: bundleName, ofType: "bundle")
            {
                ourBundle = Bundle(path: path)
            }
        }

        if ourBundle == nil {
            // This will be the same as mainBundle if not using a dynamic framework
            ourBundle = Bundle(for: internalClass)
        }

        if let ourBundle = ourBundle {
            return ourBundle
        } else {
            return Bundle.main
        }
    }
}
