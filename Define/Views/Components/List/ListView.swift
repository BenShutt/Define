//
//  ListView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// App usage of `List`
struct ListView<Element, Content: View>: View {

    /// `Identifiable` elements to iterate over
    var elements: [Element]

    /// Map `Element` to `Content`
    @ViewBuilder var content: (Int, Element) -> Content

    /// Make `List` of `Element`s
    var body: some View {
        List(elements.zipped, id: \.0) { indexElement in
            VStack(spacing: 0) {
                if indexElement.index > 0 {
                    Separator()
                }

                content(indexElement.index, indexElement.element)
            }
            .listRowInsets(.zero)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollDismissesKeyboard(.interactively)
    }
}

// MARK: - Extensions

extension ListView {

    /// Initialize omitting the argument label
    ///
    /// - Parameters:
    ///   - elements: `[Element]`
    ///   - content: View builder
    init(_ elements: [Element], content: @escaping (Int, Element) -> Content) {
        self.init(elements: elements, content: content)
    }
}
