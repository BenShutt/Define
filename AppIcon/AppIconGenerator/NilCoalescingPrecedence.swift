//
//  NilCoalescingPrecedence.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 29/09/2023.
//

import Foundation

infix operator ?!: NilCoalescingPrecedence

/// Throws the right hand side error if the left hand side optional is `nil`.
func ?!<T>(value: T?, error: @autoclosure () -> Error) throws -> T {
    guard let value = value else {
        throw error()
    }
    return value
}
