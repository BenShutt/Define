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

    /// Is the reference library been presented
    @State private var isPresentingReferenceLibrary = false

    /// When true, add padding to the search state UI
    private var statePadding: Bool {
        viewModel.inReferenceLibrary || viewModel.words.isEmpty
    }

    /// `View` of the screen
    var screen: some View {
        VStack(spacing: 0) {
            SearchHeaderView(searchText: $viewModel.search)
                .zIndex(1)

            if viewModel.inReferenceLibrary {
                Button(action: {
                    isPresentingReferenceLibrary = true
                }, label: {
                    ReferenceLibraryCard(word: viewModel.search)
                })
                .padding(.horizontal, .hMargin)
                .padding(.top, .large)
            }

            SearchStateView(viewModel: viewModel)
                .padding(.top, statePadding ? .large : 0)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .toolbarBackground(Color.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(words.isEmpty)
        .sheet(isPresented: $isPresentingReferenceLibrary) {
            ReferenceLibraryScreen(term: viewModel.search) {
                isPresentingReferenceLibrary = false
                words.saveWord(
                    .init(word: viewModel.search),
                    source: .referenceLibrary
                )
                navigation.popToRoot()
            }
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
                title: .SearchScreen.Empty.title,
                subtitle: .SearchScreen.Empty.subtitle
            )

        case .loading:
            LoadingView()

        case .failure:
            if !viewModel.inReferenceLibrary {
                SearchEmptyView(
                    lottie: .searchNoResults,
                    title: .SearchScreen.NoResults.title,
                    subtitle: .SearchScreen.NoResults.subtitle(viewModel.search)
                )
            } else {
                Text("search_api_failure")
                    .body()
                    .padding(.horizontal, .large)
                    .multilineTextAlignment(.center)
            }

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
