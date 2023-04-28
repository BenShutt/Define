//
//  ScrollVStack.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// A `ScrollView` with a `LazyVStack`
struct ScrollVStack<Element: Identifiable, Content: View>: View {

    var elements: [Element]
    @ViewBuilder var content: (Element) -> Content

    private var vPadding: CGFloat {
        elements.isEmpty ? 0 : .vMargin * 0.5
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(elements) { element in
                    content(element)
                }
            }
            .padding(.vertical, vPadding) // TODO: Opinionated
        }
    }
}

// MARK: - Extensions

extension ScrollVStack {

    init(
        _ elements: [Element],
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.init(elements: elements, content: content)
    }
}
