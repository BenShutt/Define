//
//  DateComponentsFormatter+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import Foundation

extension DateComponentsFormatter {

    /// `DateComponentsFormatter` that formats date intervals starting with years
    /// until seconds by only showing the value of the largest unit.
    ///
    /// `1s -> 1 second`
    /// `59s -> 59 seconds`
    /// `60s -> 1 minute`
    /// `124s -> 2 minutes` (4 seconds dropped)
    static var timeInterval: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = .all
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        return formatter
    }
}

// MARK: - NSCalendar.Unit + Values

private extension NSCalendar.Unit {

    /// All calendar units
    /// - Note: Only these are supported (at time of writing)
    static let all: NSCalendar.Unit = [
        .year, .month, .weekOfMonth, .day, .hour, .minute, .second
    ]
}
