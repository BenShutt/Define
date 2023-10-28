//
//  Calendar+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import Foundation

extension Calendar {

    /// Get ISO8601 formatted string date components (not including milliseconds)
    /// - Parameter date: `Date`
    /// - Returns: `DateComponents`
    func dateTimeComponents(from date: Date) -> DateComponents {
        dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
    }
    
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

    /// Set time components to midnight (start of day)
    /// - Parameter date: `Date`
    /// - Returns: `Date`
    func startOfDay(of date: Date) -> Date {
        self.date(bySettingHour: 0, minute: 0, second: 0, of: date) ?? date
    }
}
