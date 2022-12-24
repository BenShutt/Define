//
//  NavigationViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// A nvaigatiion destination
enum NavigationRoute: Hashable {

    /// Search word screen
    case search

    /// Word detail screen (definitions)
    case word(Word)
}

/// View model for navigation
final class NavigationViewModel: ObservableObject {

    /// `NavigationPath`
    @Published var path = NavigationPath()

    /// Get the root `View`
    @ViewBuilder var rootView: some View {
        Group {
            if DefinitionDAO.savedWords.isEmpty {
                SearchScreen()
            } else {
                DefinitionsScreen()
            }
        }
        .navigationDestination(for: NavigationRoute.self) { route in
            Self.destination(for: route)
        }
    }

    /// Map to `View` for `route`
    /// - Parameter route: `NavigationRoute`
    /// - Returns: `View`
    @ViewBuilder static func destination(for route: NavigationRoute) -> some View {
        switch route {
        case .search:
            SearchScreen()
        case let .word(word):
            WordScreen(word: word)
        }
    }
}
