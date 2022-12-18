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
    @ViewBuilder var content: (Element) -> Content

    /// Index elements tuple
    private var indexElements: [(index: Int, element: Element)] {
        Array(zip(elements.indices, elements))
    }

    /// Make `List` of `Element`s
    var body: some View {
        List(indexElements, id: \.0) { indexElement in
            VStack(spacing: 0) {
                if indexElement.index > 0 {
                    Rectangle() // Separator
                        .fill(Color.appLightGray)
                        .frame(height: 2)
                }

                content(indexElement.element)
            }
            .listRowInsets(.zero)
            .listRowSeparator(.hidden)
        }
        .scrollDismissesKeyboard(.immediately) // Working?
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
