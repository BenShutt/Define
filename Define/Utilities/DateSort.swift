//
//  DateSort.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import Foundation

// TODO: Unused (also, could use #keyPath instead of protocol?)

protocol DateSortable {
    var date: Date { get }
}

struct DateSort {

    enum Group {
        case today
        case lastWeek
        case lastMonth
        case other
    }

    private func group(of element: some DateSortable) -> Group {
        let today = Calendar.current.startOfDay(of: Date())
        guard element.date < today else { return .today }

        let lastWeek = Calendar.current.adding(.weekOfYear, value: -1, to: today)
        guard element.date < lastWeek else { return .lastWeek }

        let lastMonth = Calendar.current.adding(.month, value: -1, to: today)
        guard element.date < lastMonth else { return .lastMonth }

        return .other
    }

    func group<Element: DateSortable>(_ elements: [Element]) -> [Group: [Element]] {
        elements.reduce(into: [:]) { map, element in
            let group = group(of: element)
            map[group, default: []] += [element]
        }
    }
}
