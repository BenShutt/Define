//
//  SearchScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import UIKit
import SwiftUI

/// `View` to input a word to search for definitions
struct SearchScreen: Screen {

    /// `SearchViewModel`
    @ObservedObject private var viewModel = SearchViewModel()

    /// `View` of the screen
    var screenBody: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.searchText)
                .zIndex(1)

            if viewModel.state != .list {
                Spacer()
                    .frame(height: .large)
            }

            switch viewModel.state {
            case .loading:
                LoadingView()

            case .list:
                ListView(viewModel.words) { word in
                    AppNavigationLink(destination: WordScreen(word: word)) {
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
