//
//  DateGroup.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import SwiftUI

enum DateGroup: Int, Equatable, Hashable, Comparable {
    case today
    case lastWeek
    case lastMonth
    case other

    static func < (lhs: DateGroup, rhs: DateGroup) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    private static func group(for date: Date) -> DateGroup {
        let today = Calendar.current.startOfDay(of: Date())
        guard date < today else { return .today }

        let lastWeek = Calendar.current.adding(.weekOfYear, value: -1, to: today)
        guard date < lastWeek else { return .lastWeek }

        let lastMonth = Calendar.current.adding(.month, value: -1, to: today)
        guard date < lastMonth else { return .lastMonth }

        return .other
    }

    static func group<Element>(
        _ elements: [Element],
        keyPath: KeyPath<Element, Date>
    ) -> [(DateGroup, [Element])] {
        elements
            .reduce(into: [:]) { map, element in
                let group = group(for: element[keyPath: keyPath])
                map[group, default: []] += [element]
            }
            .sorted { lhs, rhs in
                lhs.key < rhs.key
            }
    }
}

// MARK: DateGroup + SwiftUI

extension DateGroup {

    var title: LocalizedStringKey {
        switch self {
        case .today: "date_group_today"
        case .lastWeek: "date_group_last_week"
        case .lastMonth: "date_group_last_month"
        case .other: "date_group_other"
        }
    }
}
