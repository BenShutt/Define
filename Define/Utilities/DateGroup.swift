//
//  DateGroup.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import SwiftUI

// TODO: Recompute start of each day?

struct DateGroup<Element: Equatable>: Identifiable, Equatable, Comparable {
    enum Group: Int, Equatable {
        case today
        case lastWeek
        case lastMonth
        case other
    }

    var group: Group
    var elements: [Element]
    var id: Group { group }

    var title: LocalizedStringKey {
        switch group {
        case .today: "date_group_today"
        case .lastWeek: "date_group_last_week"
        case .lastMonth: "date_group_last_month"
        case .other: "date_group_other"
        }
    }

    // MARK: - Comparable

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.group.rawValue < rhs.group.rawValue
    }

    // MARK: - Group

    private static func group(for date: Date) -> Group {
        let calendar: Calendar = .current
        let today = calendar.startOfDay(for: Date())
        guard date < today else { return .today }

        let lastWeek = calendar.adding(.weekOfYear, value: -1, to: today) ?? today
        guard date < lastWeek else { return .lastWeek }

        let lastMonth = calendar.adding(.month, value: -1, to: today) ?? today
        guard date < lastMonth else { return .lastMonth }

        return .other
    }

    static func group(
        _ elements: [Element],
        by keyPath: KeyPath<Element, Date>
    ) -> [DateGroup] {
        elements
            .reduce(into: [:]) { map, element in
                let group = group(for: element[keyPath: keyPath])
                map[group, default: []] += [element]
            }
            .map { DateGroup(group: $0.key, elements: $0.value) }
            .sorted()
    }
}
