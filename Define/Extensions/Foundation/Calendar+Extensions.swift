//
//  Calendar+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import Foundation

extension Calendar {

    /// Get the number of minutes from `from` to `to`
    /// - Parameters:
    ///   - from: `Date` from
    ///   - to: `Date` to
    /// - Returns: `Int` number of minutes
    func minutes(from: Date, to: Date) -> Int {
        dateComponents(
            [.minute],
            from: from,
            to: to
        ).minute ?? 0
    }

    /// Add `value` days to `date`
    /// - Parameters:
    ///   - value: Amount of days
    ///   - date: Date to add days to
    /// - Returns: Outputted date
    func addingDays(_ value: Int, to date: Date) -> Date {
        self.date(
            byAdding: .day,
            value: value,
            to: date
        ) ?? date
    }
}
