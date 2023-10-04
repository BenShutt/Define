//
//  SearchScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct SearchScreen: Screen {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// `SearchViewModel`
    @StateObject private var viewModel = SearchViewModel()

    /// `View` of the screen
    var screen: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.search)
                .zIndex(1)

            if viewModel.inReferenceLibrary || true { // TODO
                Button(action: {
                    navigation.push(.referenceLibrary(term: viewModel.search))
                }, label: {
                    ReferenceLibraryCard(word: viewModel.search)
                })
                .padding(EdgeInsets.margins)
            }

            SearchStateView(viewModel: viewModel)
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

// MARK: - SearchStateView

private struct SearchStateView: View {

    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        switch viewModel.state {
        case .emptySearch:
            SearchEmptyView(
                lottie: .searchEmpty,
                lottieTransform: .init(scaleX: 1.5, y: 1.5),
                title: .SearchScreen.Empty.title,
                subtitle: .SearchScreen.Empty.subtitle
            )
            .padding(.top, .large)

        case .loading:
            LoadingView()
                .padding(.top, .large)

        case .failure:
            SearchEmptyView(
                lottie: .searchNoResults,
                title: .SearchScreen.NoResults.title,
                subtitle: .SearchScreen.NoResults.subtitle(viewModel.search)
            )
            .padding(.top, .large)

        case let .success(words):
            MarginedList(words.identified, route: {
                .word($0.element)
            }, content: {
                WordListItem(word: $0.element)
            })
        }
    }
}

// MARK: - Preview

#Preview {
    SearchScreen()
        .environmentObject(NavigationViewModel())
        .environmentObject(WordsViewModel())
}
