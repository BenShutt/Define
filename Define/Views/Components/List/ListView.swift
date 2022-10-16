//
//  ListView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// App usage of `List`
struct ListView<Element: Identifiable, Content: View>: View {

    /// `Identifiable` elements to iterate over
    var elements: [Element]

    /// Map `Element` to `Content`
    @ViewBuilder var content: (Element) -> Content

    /// Make `List` of `Element`s
    var body: some View {
        List(elements) { element in
            content(element)
                .listRowInsets(.zero)
                .listRowSeparator(.automatic)
        }
        .listStyle(.plain)
    }
}

// MARK: - Extensions

extension ListView {

    /// Initialize omitting the argument label
    ///
    /// - Parameters:
    ///   - elements: `[Element]`
    ///   - content: View builder
    init(_ elements: [Element], content: @escaping (Element) -> Content) {
        self.init(elements: elements, content: content)
    }
}
