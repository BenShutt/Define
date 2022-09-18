//
//  JSONEncoder+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

extension JSONEncoder {

    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    static var pretty: JSONEncoder {
        let encoder = JSONEncoder.default
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }
}
