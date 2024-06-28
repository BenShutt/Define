//
//  SearchScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct SearchScreen: View {
    @EnvironmentObject private var words: WordsViewModel
    @Environment(\.popToRoot) private var popToRoot

    /// `SearchViewModel`
    @StateObject private var viewModel = SearchViewModel()

    /// Is the search field focused
    @FocusState private var isSearchFocused: Bool

    /// When true, add padding to the search state UI
    private var statePadding: Bool {
        viewModel.words.isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.search)
                .focused($isSearchFocused) // Become first responder
                .zIndex(1)

            SearchStateView(viewModel: viewModel)
                .padding(.top, statePadding ? .large : 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .screen()
        .toolbarBackground(Color.clear, for: .navigationBar)
        .toolbar(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(words.isEmpty)
        .onAppear {
            isSearchFocused = true
        }
    }
}

// MARK: - SearchStateView

private struct SearchStateView: View {
    @Environment(\.push) private var push
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        switch viewModel.state {
        case .emptySearch:
            SearchEmptyView(
                lottie: .searchEmpty,
                lottieTransform: .init(scaleX: 1.5, y: 1.5),
                title: "search_empty_title",
                subtitle: "search_empty_subtitle"
            )

        case .loading:
            LoadingView()

        case .failure:
            SearchEmptyView(
                lottie: .searchNoResults,
                title: "search_no_results_title",
                subtitle: "search_no_results_subtitle \(viewModel.search)"
            )

        case let .success(words):
            MarginedList(words.identified) { indexElement in
                Button(action: {
                    push(.word(indexElement.element))
                }, label: {
                    WordListItem(word: indexElement.element)
                })
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SearchScreen()
        .environmentObjects()
}
