//
//  NilCoalescingPrecedence.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import Foundation

// swiftlint:disable static_operator operator_whitespace

// MARK: - ?!

/// Make `?!` operator to throw errors on `nil`
infix operator ?!: NilCoalescingPrecedence

/// Throws the right hand side error if the left hand side optional is `nil`.
func ?!<T>(value: T?, onError: @autoclosure () -> Error) throws -> T {
    guard let value = value else { throw onError() }
    return value
}

// swiftlint:enable static_operator operator_whitespace
