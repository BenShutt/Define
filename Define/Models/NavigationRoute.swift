//
//  NavigationRoute.swift
//  Define
//
//  Created by Ben Shutt on 24/06/2024.
//

import SwiftUI
import DictionaryAPI

/// A navigation destination
enum NavigationRoute: Hashable {

    /// Search word screen
    case search

    /// Word detail screen (meanings and their definitions)
    case word(Word)

    /// Map to a respective view
    @ViewBuilder var screen: some View {
        switch self {
        case .search:
            SearchScreen()
        case let .word(word):
            WordScreen(word: word)
        }
    }
}

// MARK: - View + NavigationRoute

extension View {

    /// Add navigation destination handler to view
    func navigateRoutes() -> some View {
        navigationDestination(for: NavigationRoute.self) { route in
            route.screen
                .toolbar(.hidden, for: .tabBar)
        }
    }
}
