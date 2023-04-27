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

    /// `NavigationBarStyle`
    var navigationBarStyle: NavigationBarStyle {
        .clear
    }

    /// `View` of the screen
    var screen: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.search)
                .zIndex(1)

            if viewModel.words.isEmpty {
                Spacer()
                    .frame(height: .large)
            }

            switch viewModel.state {
            case .emptySearch:
                SearchEmptyView(
                    lottie: .searchEmpty,
                    lottieTransform: .init(scaleX: 1.5, y: 1.5),
                    title: .SearchScreen.Empty.title,
                    subtitle: .SearchScreen.Empty.subtitle
                )

            case .loading:
                LoadingView()

            case .failure:
                SearchEmptyView(
                    lottie: .searchNoResults,
                    title: .SearchScreen.NoResults.title,
                    subtitle: .SearchScreen.NoResults.subtitle(viewModel.search)
                )

            case let .success(words):
                ListView(words) { _, word in
                    AppNavigationLink(value: NavigationRoute.word(word)) {
                        WordListItemView(word: word)
                    }
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

// MARK: - PreviewProvider

struct SearchScreen_Previews: PreviewProvider {

    static var previews: some View {
        SearchScreen()
    }
}
