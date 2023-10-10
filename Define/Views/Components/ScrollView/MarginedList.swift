//
//  MarginedList.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI

/// Scrolled vertical stack of elements
struct MarginedList<Element: Identifiable, Content: View>: View {

    /// `EdgeInsets` to apply as padding around the edge of the cells
    private let margins: EdgeInsets = .margins

    /// Elements to layout
    var elements: [Element]

    /// Should the list be animated
    var isAnimated: Bool

    /// The items that have appeared
    @State private var appearedItems: Set<Int> = []

    /// Subview content
    @ViewBuilder var content: (Element) -> Content

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(elements.zipped, id: \.0) { index, element in
                    content(element)
                        .margined(margins)
                        .if(isAnimated) { content in
                            content.modifier(ListAnimator(
                                appearedItems: $appearedItems,
                                index: index
                            ))
                        }
                }
            }
            .marginedStack(margins)
        }
    }
}

// MARK: View + Extensions

private extension View {

    /// Wrap in a margined container
    /// - Parameter margins: `EdgeInsets`
    /// - Returns: `View`
    func margined(_ margins: EdgeInsets) -> some View {
        self.roundedRectangleBorder(color: .appGray.opacity(0.15), borderWidth: 1)
            .compositingGroup()
            .shadow(.container)
            .padding(margins)
    }

    /// Apply padding to a stack containing margined cells
    /// - Parameter margins: `EdgeInsets`
    /// - Returns: `View`
    func marginedStack(_ margins: EdgeInsets) -> some View {
        self.padding(.top, margins.top)
            .padding(.bottom, margins.bottom)
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
