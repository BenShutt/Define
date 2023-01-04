//
//  SearchScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct SearchScreen: Screen {

    /// `SearchViewModel`
    @StateObject private var viewModel = SearchViewModel()

    /// Override `NavigationBarStyle`
    var navigationBarStyle: NavigationBarStyle {
        .clear
    }

    /// `View` of the screen
    var screenBody: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.searchText)
                .zIndex(1)

            if viewModel.state != .list {
                VSpacer(height: .large)
            }

            switch viewModel.state {
            case .loading:
                LoadingView()

            case .list:
                ListView(viewModel.words) { _, word in
                    AppNavigationLink(value: NavigationRoute.word(word)) {
                        WordListItemView(word: word)
                    }
                }

            case .noResults:
                SearchEmptyView(
                    lottie: .searchNoResults,
                    title: .SearchScreen.NoResults.title,
                    subtitle: .SearchScreen.NoResults.subtitle(viewModel.searchText)
                )

            case .empty:
                SearchEmptyView(
                    lottie: .searchEmpty,
                    lottieTransform: .init(scaleX: 1.5, y: 1.5),
                    title: .SearchScreen.Empty.title,
                    subtitle: .SearchScreen.Empty.subtitle
                )
            }

            Spacer()
        }
    }
}

// MARK: - PreviewProvider

struct SearchScreen_Previews: PreviewProvider {

    static var previews: some View {
        SearchScreen()
    }
}
