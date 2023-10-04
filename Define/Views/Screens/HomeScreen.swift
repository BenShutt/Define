//
//  HomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct HomeScreen: View {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// The word to show in a presented reference library modal
    @State private var selectedWord: SavedWord?

    var body: some View {
        MarginedList(words.words) { word in
            WordRow(selectedWord: $selectedWord, word: word)
        }
        .screen()
        .stickyHeader(
            title: .HomeScreen.title,
            subtitle: .HomeScreen.subtitle,
            color: .appGreen
        )
        .stickyButton(
            title: .HomeScreen.addWordButton,
            systemName: "magnifyingglass"
        ) {
            navigation.push(.search)
        }
        .toolbarBackground(Color.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedWord) { savedWord in
            ReferenceLibraryScreen(term: savedWord.word.word) {
                selectedWord = nil
            }
        }
    }
}

// MARK: - WordRow

private struct WordRow: View {

    @Binding var selectedWord: SavedWord?
    var word: SavedWord

    var body: some View {
        switch word.source {
        case .api:
            NavigationLink(.word(word.word)) {
                WordListItem(word: word.word, caption: word.addedSince)
            }

        case .referenceLibrary:
            Button(action: {
                selectedWord = word
            }, label: {
                WordListItem(word: word.word, caption: word.addedSince)
            })
        }
    }
}

// MARK: - PreviewProvider

struct HomeScreen_Previews: PreviewProvider {

    static var previews: some View {
        HomeScreen()
            .environmentObject(NavigationViewModel())
            .environmentObject(WordsViewModel())
    }
}
