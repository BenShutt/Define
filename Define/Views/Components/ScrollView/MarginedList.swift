//
//  MarginedList.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI

/// Scrolled vertical stack of elements
struct MarginedList<Element, Content: View>: View {
    var elements: [Element]
    var isAnimated: Bool
    @ViewBuilder var content: (Element) -> Content

    var body: some View {
        ScrollView {
            MarginedStack(
                elements: elements,
                isAnimated: isAnimated,
                content: content
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - MarginedStack

struct MarginedStack<Element, Content: View>: View {
    var elements: [Element]
    var isAnimated: Bool
    @ViewBuilder var content: (Element) -> Content

    @State private var appearedItems: Set<Int> = []

    var body: some View {
        VStack(spacing: .vMargin) { // TODO: Not LazyVStack due to ListAnimator
            ForEach(elements.zipped, id: \.0) { index, element in
                content(element)
                    .container()
                    .padding(.horizontal, .hMargin)
                    .listAnimator(
                        appearedItems: $appearedItems,
                        index: index,
                        isEnabled: isAnimated
                    )
            }
        }
        .padding(.vertical, .vMargin)
    }
}

// MARK: - Extensions

extension MarginedList {

    /// Initialize omitting the argument label
    /// - Parameters:
    ///   - elements: `[Element]`
    ///   - isAnimated: Animate the list items
    ///   - content: Content view
    init(
        _ elements: [Element],
        isAnimated: Bool = false,
        content: @escaping (Element) -> Content
    ) {
        self.init(
            elements: elements,
            isAnimated: isAnimated,
            content: content
        )
    }
}
