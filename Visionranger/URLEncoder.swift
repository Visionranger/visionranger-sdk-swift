//
//  URLEncoder.swift
//  URLEncoder
//
//  Created by Colin Tessarzick on 23.09.21.
//

import Foundation

public final class URLEncoder {
    public class func string(byURLEncoding string: String) -> String {
        return escape(string)
    }
    
    public class func stringByReplacingSnakeCase(withCamelCase input: String) -> String {
        let parts: [String] = input.components(separatedBy: "_")
        var camelCaseParam = ""
        for (idx, part) in parts.enumerated() {
            camelCaseParam += idx == 0 ? part : part.capitalized
        }

        return camelCaseParam
    }
    
    public class func queryString(from parameters: [String: Any]) -> String {
        return query(parameters)
    }
}


struct Key {
    enum Part {
        case normal(String)
        case dontEscape(String)
    }
    let parts: [Part]
}


private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    func unwrap<T>(_ any: T) -> Any {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional, let first = mirror.children.first else {
            return any
        }
        return first.value
    }

    var components: [(String, String)] = []
    switch value {
    case let dictionary as [String: Any]:
        for nestedKey in dictionary.keys.sorted() {
            let value = dictionary[nestedKey]!
            let escapedNestedKey = escape(nestedKey)
            components += queryComponents(fromKey: "\(key)[\(escapedNestedKey)]", value: value)
        }
    case let array as [Any]:
        for (index, value) in array.enumerated() {
            components += queryComponents(fromKey: "\(key)[\(index)]", value: value)
        }
    case let number as NSNumber:
        if number.isBool {
            components.append((key, escape(number.boolValue ? "true" : "false")))
        } else {
            components.append((key, escape("\(number)")))
        }
    case let bool as Bool:
        components.append((key, escape(bool ? "true" : "false")))
    case let set as Set<AnyHashable>:
        for value in Array(set) {
            components += queryComponents(fromKey: "\(key)", value: value)
        }
    default:
        let unwrappedValue = unwrap(value)
        components.append((key, escape("\(unwrappedValue)")))
    }
    return components
}

private func escape(_ string: String) -> String {
    string.addingPercentEncoding(withAllowedCharacters: URLQueryAllowed) ?? string
}

private func query(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []

    for key in parameters.keys.sorted(by: <) {
        let value = parameters[key]!
        components += queryComponents(fromKey: escape(key), value: value)
    }
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
}

private let URLQueryAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@"  // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="
    let encodableDelimiters = CharacterSet(
        charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

    return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
}()


extension NSNumber {
    fileprivate var isBool: Bool {
        // Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
        // swift-corelibs-foundation, per [this discussion on the Swift forums](https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
        String(cString: objCType) == "c"
    }
}
