//
//  TimeRemaining.swift
//  Define
//
//  Created by Ben Shutt on 24/10/2023.
//

import Foundation

struct TimeRemaining: Identifiable {

    var fromDate = Date()
    var toDate: Date

    var formattedString: String {
        DateComponentsFormatter.timeInterval.string(
            from: fromDate,
            to: toDate
        ) ?? ""
    }

    var id: String {
        formattedString
    }
}
