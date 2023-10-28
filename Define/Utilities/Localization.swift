//
//  Localization.swift
//  Define
//
//  Created by Ben Shutt on 06/10/2023.
//

import SwiftUI

// MARK: - Localization

/// Typically we'd use `LocalizedStringKey` , this is used for legacy APIs like
/// setting the `title` of a `UNMutableNotificationContent`
struct Localization {

    let key: String
    let arguments: [Any]

    var value: String {
        NSString.localizedUserNotificationString(
            forKey: key,
            arguments: arguments.isEmpty ? nil : arguments
        )
    }
}

// MARK: - ExpressibleByStringInterpolation

extension Localization: ExpressibleByStringInterpolation {

    init(stringLiteral value: String) {
        key = value
        arguments = []
    }

    init(stringInterpolation: StringInterpolation) {
        key = stringInterpolation.key
        arguments = stringInterpolation.arguments
        assert(!key.isEmpty)
    }

    /// Usage: `<key> <arg1> <arg2>`
    struct StringInterpolation: StringInterpolationProtocol {

        var key = ""
        var arguments: [Any] = []

        init(literalCapacity: Int, interpolationCount: Int) {
            key.reserveCapacity(literalCapacity)
            arguments.reserveCapacity(interpolationCount)
        }

        mutating func appendLiteral(_ literal: String) {
            key.append(literal.trimmed)
        }

        mutating func appendInterpolation(_ value: Int) {
            key += " %lld"
            arguments.append(value)
        }

        mutating func appendInterpolation(_ value: Int8) {
            key += " %d"
            arguments.append(value)
        }

        mutating func appendInterpolation(_ value: String) {
            key += " %@"
            arguments.append(value)
        }
    }
}
