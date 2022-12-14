//
//  NavigationViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI
import DictionaryAPI

/// A navigation destination
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
    /// - Parameter words: `WordsViewModel`
    /// - Returns: `View`
    @ViewBuilder func rootView(words: WordsViewModel) -> some View {
        Group {
            if words.words.isEmpty {
                SearchScreen()
            } else {
                DefinitionsScreen()
            }
        }
        .navigationDestination(for: NavigationRoute.self) { route in
            switch route {
            case .search:
                SearchScreen()
            case let .word(word):
                WordScreen(word: word)
            }
        }
    }

    /// Push `route` on `path`
    /// - Parameter route: `NavigationRoute`
    func push(_ route: NavigationRoute) {
        path.append(route)
    }

    /// Pop to root screen
    func popToRoot() {
        path = NavigationPath()
    }
}
