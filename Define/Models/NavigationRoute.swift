//
//  NavigationRoute.swift
//  Define
//
//  Created by Ben Shutt on 24/06/2024.
//

import SwiftUI
import DictionaryAPI

// MARK: - NavigationRoute

/// A navigation destination
enum NavigationRoute: Hashable {

    /// Search word screen
    case search

    /// Word detail screen (definitions)
    case word(Word)
}

// MARK: - View + NavigationRoute

extension View {

    /// Add navigation destination handler to view
    func navigateRoutes() -> some View {
        navigationDestination(for: NavigationRoute.self) { route in
            switch route {
            case .search:
                SearchScreen()
            case let .word(word):
                WordScreen(word: word)
            }
        }
    }
}

// MARK: - NavigationLink + NavigationRoute

extension NavigationLink where Destination == Never {
    init(
        _ route: NavigationRoute,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(value: route, label: label)
    }
}
