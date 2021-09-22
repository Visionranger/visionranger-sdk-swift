//
//  AccessKeyProvider.swift
//  AccessKeyProvider
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

/// Provides an access key
public protocol AccessKeyProvider {
    var accessKey: String? { get }
}
