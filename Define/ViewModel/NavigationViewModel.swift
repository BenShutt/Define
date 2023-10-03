//
//  NavigationViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
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

// MARK: - NavigationViewModel

/// View model for navigation
final class NavigationViewModel: ObservableObject {

    /// Shared static singleton for use outside of SwiftUI views
    static let shared = NavigationViewModel() // TODO: Why singleton?

    /// `NavigationPath`
    @Published var path = NavigationPath()

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

// MARK: - View + NavigationRoute

extension View {

    /// Add navigation destination handler to view
    func navigate() -> some View {
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
