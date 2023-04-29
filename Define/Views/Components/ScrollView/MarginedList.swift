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

    /// Route to navigate to on tap
    var route: ((Element) -> NavigationRoute)?

    /// Subview content
    @ViewBuilder var content: (Element) -> Content

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(elements) { element in
                    if let route {
                        NavigationLink(route(element)) {
                            content(element)
                                .margined(margins)
                        }
                    } else {
                        content(element)
                            .margined(margins)
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
        self.cornerRadius(.cornerRadius)
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
    ///
    /// - Parameters:
    ///   - elements: `[Element]`
    ///   - route: Navigated route
    ///   - content: Content view
    init(
        _ elements: [Element],
        route: ((Element) -> NavigationRoute)? = nil,
        content: @escaping (Element) -> Content
    ) {
        self.init(
            elements: elements,
            route: route,
            content: content
        )
    }
}
