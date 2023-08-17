//
//  JSONEncoder+Extensions.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

extension JSONEncoder {

    /// `JSONEncoder` for the API
    static var api: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    /// `JSONEncoder` for pretty printing
    static var pretty: JSONEncoder {
        let encoder = JSONEncoder.api
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        return encoder
    }
}
