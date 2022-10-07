//
//  EnterWordScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import UIKit
import SwiftUI

/// `View` to input a word to search for definitions
struct EnterWordScreen: Screen {

    /// `SearchViewModel`
    @ObservedObject private var viewModel = SearchViewModel()

    /// `[Word]` returned from the API
    var words: [Word] {
        viewModel.result.success?.results ?? []
    }

    /// Get the text in the search field
    var searchText: String {
        viewModel.searchText
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
                List {
                    ForEach(words) {
                        WordListItemView(word: $0, onTap: { /* TODO */ })
                    }
                }
                .listStyle(PlainListStyle())
            } else if !searchText.isEmpty {
                SearchNoResults(word: searchText)
            } else {
                SearchEmpty()
            }

            Spacer()
        }
    }

    /// Save the given `word`
    /// - Parameter word: `String`
    private func saveWord(word: String) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}

// MARK: - PreviewProvider

struct EnterWordScreen_Previews: PreviewProvider {
    static var previews: some View {
        EnterWordScreen()
    }
}
