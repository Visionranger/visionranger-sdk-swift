//
//  VSNAssociatedPlaneAnchor.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 09.12.21.
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

public enum VSNAssociatedPlaneAnchor: String {
    /// Used for products that are placed on the floor (e.g. tables, sofas)
    case floor = "floor"
    /// Used for products that are placed on the wall (e.g. rugs, paintings)
    case wall = "wall"
    /// Used for products that are placed on the ceiling (e.g. pendant lighting)
    case ceiling = "ceiling"
    /// The product's associated plane is unknown or does not match any of the standard cases
    case unknown = "unknown"
    
    public var localizedDescription: String {
        switch self {
        case .floor:
            return VSNLocalizedString("Floor", comment: "Associated planar surface anchor of the product")
        case .wall:
            return VSNLocalizedString("Wall", comment: "Associated planar surface anchor of the product")
        case .ceiling:
            return VSNLocalizedString("Ceiling", comment: "Associated planar surface anchor of the product")
        case .unknown:
            fallthrough
        default:
            return VSNLocalizedString("Unknown", comment: "Default missing associated plane anchor label")
        }
    }
}
