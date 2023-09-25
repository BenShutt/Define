//
//  JSONModel.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

/// A `Codable` which can be represented as a JSON `String`
public protocol JSONModel: Codable, Equatable, Hashable, CustomStringConvertible {}

// MARK: - Extensions

public extension JSONModel {

    /// Encode (pretty printed) JSON data as a `String`
    func jsonString() throws -> String {
        try String(
            decoding: JSONEncoder.pretty.encode(self),
            as: UTF8.self
        )
    }

    /// By default, return `jsonString()` or type `String` on throw
    var description: String {
        (try? jsonString()) ?? "\(type(of: self))"
    }
}

// MARK: - JSONEncoder + Extensions

private extension JSONEncoder {

    /// `JSONEncoder` for pretty printing
    static var pretty: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        return encoder
    }
}
