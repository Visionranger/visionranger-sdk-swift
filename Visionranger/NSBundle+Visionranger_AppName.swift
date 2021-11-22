//
//  NSBundle+Visionranger_AppName.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 22.11.21.
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

extension Bundle {
    public class func vsn_applicationName() -> String? {
        return self.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }

    public class func vsn_applicationVersion() -> String? {
        return self.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    public class var displayName: String? {
        return self.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? self.main
            .object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
