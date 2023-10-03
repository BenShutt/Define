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

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// `View` of the screen
    var screen: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.search)
                .zIndex(1)
                .padding(.bottom, viewModel.words.isEmpty ? .large : 0)

            if viewModel.inReferenceLibrary {
                ReferenceLibraryCard(word: viewModel.search) // TODO
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
                MarginedList(words.identified, route: {
                    .word($0.element)
                }, content: {
                    WordListItem(word: $0.element)
                })
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .toolbarBackground(Color.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(words.isEmpty)
    }
}

// MARK: - PreviewProvider

struct SearchScreen_Previews: PreviewProvider {

    static var previews: some View {
        SearchScreen()
    }
}
