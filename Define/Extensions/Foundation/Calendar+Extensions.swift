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
}
