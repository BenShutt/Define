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

    /// `[Word]` returned from the API
    var words: [Word] {
        viewModel.result.success?.results ?? []
    }

    /// `View` of the screen
    var screenBody: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.searchText)

            Spacer()
                .frame(height: .large)

            if viewModel.isLoading {
                LoadingView()
            } else if !words.isEmpty {
                ListView(words) { word in
                    NavigationLink {
                        WordScreen(word: word)
                    } label: {
                        WordListItemView(word: word)
                    }
                }
            } else if !viewModel.searchText.isEmpty {
                SearchEmptyView(
                    lottie: .searchNoResults,
                    title: .SearchScreen.NoResults.title,
                    subtitle: .SearchScreen.NoResults.subtitle(viewModel.searchText)
                )
            } else {
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
