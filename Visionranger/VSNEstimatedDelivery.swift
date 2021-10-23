//
//  VSNEstimatedDelivery.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 24.09.21.
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

public enum VSNEstimatedDelivery: Int {
    case threeToFiveDays
    case upToOneWeek
    case oneToTwoWeeks
    case twoWeeks
    case twoToThreeWeeks
    case threeWeeks
    case threeToFourWeeks
    case fourToSixWeeks
    case sixWeeksToTwoMonths
    case twoMonths
    case twoToThreeMonths
    case moreThanThreeMonths
    case unknown
    
    public var string: String {
        switch self {
        case .threeToFiveDays:
            return NSLocalizedString("3 - 5 days", comment: "Estimated time between order and delivery")
        case .upToOneWeek:
            return NSLocalizedString("1 week", comment: "Estimated time between order and delivery")
        case .oneToTwoWeeks:
            return NSLocalizedString("1 - 2 weeks", comment: "Estimated time between order and delivery")
        case .twoWeeks:
            return NSLocalizedString("2 weeks", comment: "Estimated time between order and delivery")
        case .twoToThreeWeeks:
            return NSLocalizedString("2 - 3 weeks", comment: "Estimated time between order and delivery")
        case .threeWeeks:
            return NSLocalizedString("3 weeks", comment: "Estimated time between order and delivery")
        case .threeToFourWeeks:
            return NSLocalizedString("3 - 4 weeks", comment: "Estimated time between order and delivery")
        case .fourToSixWeeks:
            return NSLocalizedString("4 - 6 weeks", comment: "Estimated time between order and delivery")
        case .sixWeeksToTwoMonths:
            return NSLocalizedString("6 - 8 weeks", comment: "Estimated time between order and delivery")
        case .twoMonths:
            return NSLocalizedString("2 months", comment: "Estimated time between order and delivery")
        case .twoToThreeMonths:
            return NSLocalizedString("2 - 3 months", comment: "Estimated time between order and delivery")
        case .moreThanThreeMonths:
            return NSLocalizedString("more than 3 months", comment: "Estimated time between order and delivery")
        case .unknown:
            fallthrough
        default:
            return NSLocalizedString("Unknown", comment: "Default missing delivery estimate index label")
        }
    }
}
