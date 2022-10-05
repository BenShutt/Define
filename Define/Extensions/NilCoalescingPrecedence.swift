//
//  NilCoalescingPrecedence.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import Foundation

// swiftlint:disable static_operator operator_whitespace

infix operator ?!: NilCoalescingPrecedence

/// Throws the right hand side error if the left hand side optional is `nil`.
func ?!<T>(value: T?, error: @autoclosure () -> Error) throws -> T {
    guard let value = value else {
        throw error()
    }
    return value
}
