//
//  Localization.swift
//  Define
//
//  Created by Ben Shutt on 06/10/2023.
//

import SwiftUI

protocol LocalizationArgument: LosslessStringConvertible {}
extension String: LocalizationArgument {} // %@
extension Int: LocalizationArgument {} // %lld

/// Typically we'd use `LocalizedStringKey` , this is used for legacy APIs like
/// setting the `title` of a `UNMutableNotificationContent`
struct Localization {

    let key: String
    let arguments: [LocalizationArgument]

    var interpolatedKey: String {
        var value = key
        arguments.forEach { argument in
            value += " \(argument)"
        }
        return value
    }

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
        key = stringInterpolation.key.trimmed
        arguments = stringInterpolation.arguments
        assert(!key.isEmpty)
    }

    /// Usage: `<key> <arg1> <arg2>`
    struct StringInterpolation: StringInterpolationProtocol {

        var key = ""
        var arguments: [LocalizationArgument] = []

        init(literalCapacity: Int, interpolationCount: Int) {
            key.reserveCapacity(literalCapacity)
            arguments.reserveCapacity(interpolationCount)
        }

        mutating func appendLiteral(_ literal: String) {
            key.append(literal)
        }

        mutating func appendInterpolation<Argument: LocalizationArgument>(
            _ value: Argument
        ) {
            arguments.append(value)
        }
    }
}
