//
//  VSNLocalizationUtils.swift
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

public final class VSNLocalizationUtils {
    /// Acts like NSLocalizedString but tries to find the string in the Visionranger
    /// bundle first if possible.
    /// If the main app has a localization that we do not support, we want to switch
    /// to pulling strings from the main bundle instead of our own bundle so that
    /// users can add translations for our strings without having to fork the sdk.
    /// At launch, NSBundles' store what language(s) the user requests that they
    /// actually have translations for in `preferredLocalizations`.
    /// We compare our framework's resource bundle to the main app's bundle, and
    /// if their language choice doesn't match up we switch to pulling strings
    /// from the main bundle instead.
    /// This also prevents language mismatches. E.g. the user lists portuguese and
    /// then spanish as their preferred languages. The main app supports both so all its
    /// strings are in pt, but we support spanish so our bundle marks es as our
    /// preferred language and our strings are in es.
    /// If the main bundle doesn't have the correct string, we'll always fall back to
    /// using the Visionranger bundle so we don't inadvertently show an untranslated string.
    static func localizedVisionrangerStringUseMainBundle(bundleLocator: BundleLocatorProtocol.Type) -> Bool {
        if bundleLocator.resourcesBundle.preferredLocalizations.first != Bundle.main.preferredLocalizations.first {
            return true
        }
        return false
    }

    static let unknownString = "VSNStringNotFound"

    public class func localizedVisionrangerString(forKey key: String, bundleLocator: BundleLocatorProtocol.Type) -> String {
        if languageOverride != nil {
            return testing_localizedVisionrangerString(forKey: key, bundleLocator: bundleLocator)
        }
        if localizedVisionrangerStringUseMainBundle(bundleLocator: bundleLocator) {
            // Per https://developer.apple.com/documentation/foundation/bundle/1417694-localizedstring,
            // iOS will give us an empty string if a string isn't found for the specified key.
            // Work around this by specifying an unknown sentinel string as the value. If we get that value back,
            // we know that the string wasn't present in the bundle.
            let userTranslation = Bundle.main.localizedString(
                forKey: key, value: unknownString, table: nil)
            if userTranslation != unknownString {
                return userTranslation
            }
        }

        return bundleLocator.resourcesBundle.localizedString(
            forKey: key, value: nil, table: nil)
    }

    // MARK: - Testing
    static var languageOverride: String?
    static func overrideLanguage(to string: String?) {
        VSNLocalizationUtils.languageOverride = string
    }
    static func testing_localizedVisionrangerString(forKey key: String, bundleLocator: BundleLocatorProtocol.Type) -> String {
        var bundle = bundleLocator.resourcesBundle

        if let languageOverride = languageOverride {

            let lprojPath = bundle.path(forResource: languageOverride, ofType: "lproj")
            if let lprojPath = lprojPath {
                bundle = Bundle(path: lprojPath)!
            }
        }
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}

/// Use to explicitly ignore static analyzer warning: "User-facing text should use localized string macro"
@inline(__always) public func VSNNonLocalizedString(_ string: String) -> String {
    return string
}
