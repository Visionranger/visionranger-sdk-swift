//
//  Codable.swift
//  Codable
//
//  Created by Colin Tessarzick on 22.09.21.
//

import Foundation

extension JSONDecoder {
    public static var vsnDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
