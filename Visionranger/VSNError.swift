//
//  VSNError.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 03.10.21.
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

public enum VSNErrorCode: Int {
    case connectionError = 40
    case invalidRequestError = 50
    case apiError = 60
    case cancellationError = 70
    case accessKeyDecodingError = 1000
}

public class VSNError: NSObject {
    /// All Visionranger iOS errors will be under this domain
    public static let visionrangerDomain = "com.visionranger.lib"
    
    public static let errorMessageKey = "com.visionranger.lib:ErrorMessageKey"
    
    public static let errorParameterKey = "com.visionranger.lib:ErrorParameterKey"
    
    public static let visionrangerErrorCodeKey = "com.visionranger.lib:VisionrangerErrorCodeKey"
    
    public static let visionrangerErrorTypeKey = "com.visionranger.lib:VisionrangerErrorTypeKey"
    
    public static let visionrangerDeclineCodeKey = "com.visionranger.lib:VisionrangerDeclineCodeKey"
}
