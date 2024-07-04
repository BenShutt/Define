//
//  SearchScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI
import DictionaryAPI

/// Search for a word and display the results from the API
struct SearchScreen: View {

    /// Observable encapsulating search logic
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
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
        }
        .screen()
        .toolbarBackground(Color.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .onAppear {
            isSearchFocused = true
        }
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
                title: "search_empty_title",
                subtitle: "search_empty_subtitle"
            )

        case .loading:
            LoadingView()
                .padding(.top, .large)

        case .failure:
            SearchEmptyView(
                lottie: .searchNoResults,
                title: "search_no_results_title",
                subtitle: "search_no_results_subtitle \(viewModel.search)"
            )

        case let .success(words):
            WordList(words: words)
        }
    }
}

// MARK: - WordList

private struct WordList: View {
    @Environment(\.modelContext) private var modelContext
    var words: [Word]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .vMargin) {
                ForEach(words.zipped, id: \.0) { _, word in
                    WordListItemButton(source: .init(
                        modelContext: modelContext,
                        word: word
                    ))
                    .container()
                    .padding(.horizontal, .hMargin)
                }
            }
            .padding(.vertical, .vMargin)
        }
    }
}

// MARK: - Preview

#Preview {
    SearchScreen()
        .environmentObjects()
}
