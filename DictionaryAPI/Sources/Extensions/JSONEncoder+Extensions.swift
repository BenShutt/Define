//
//  JSONEncoder+Extensions.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

extension JSONEncoder {

    static var pretty: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        return encoder
    }
}
