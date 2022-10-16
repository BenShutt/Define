//
//  JSONModel.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

/// A `Codable` which can be represented as a JSON `String`
protocol JSONModel: Codable, CustomStringConvertible {}

// MARK: - Extensions

extension JSONModel {

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
