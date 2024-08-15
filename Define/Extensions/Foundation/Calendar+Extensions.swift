//
//  Calendar+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import Foundation

extension Calendar {

    /// Shorthand to add `value` amount of `component` to `date`
    /// - Parameters:
    ///   - component: A calendar component
    ///   - value: Amount of component to add
    ///   - date: The date to add to
    /// - Returns: The new date after adding or `date` on `nil`
    func addOrDefault(
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
