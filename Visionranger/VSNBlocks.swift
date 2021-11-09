//
//  VSNBlocks.swift
//  Visionranger
//
//  Created by Colin Tessarzick on 22.09.21.
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

public typealias VSNVoidBlock = () -> Void

public typealias VSNErrorBlock = (Error?) -> Void

public typealias VSNBooleanSuccessBlock = (Bool?, Error?) -> Void

public typealias VSNJSONResponseCompletionBlock = (String?, Error?) -> Void

public typealias VSNDeleteCompletionBlock = (VSNDeletion?, Error?) -> Void

public typealias VSNProductCompletionBlock = (VSNProduct?, Error?) -> Void

public typealias VSNProductsCompletionBlock = ([VSNProduct]?, Error?) -> Void

public typealias VSNAnnouncementCompletionBlock = (VSNAnnouncement?, Error?) -> Void

public typealias VSNConfigurationCompletionBlock = (VSNConfiguration?, Error?) -> Void

public typealias VSNConfigurationsCompletionBlock = ([VSNConfiguration]?, Error?) -> Void

public typealias VSNDesignerCompletionBlock = (VSNDesigner?, Error?) -> Void
