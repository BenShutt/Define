//
//  Calendar+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import Foundation

extension Calendar {

    /// Shorthand to add `value` amount of `component` to `date` and default to `date` on `nil`
    /// - Parameters:
    ///   - component: `Calendar.Component`
    ///   - value: `Int`
    ///   - date: `Date`
    /// - Returns: `Date`
    func adding(
        _ component: Calendar.Component,
        value: Int,
        to date: Date
    ) -> Date {
        self.date(
            byAdding: component,
            value: value,
            to: date
        ) ?? date
    }
}
