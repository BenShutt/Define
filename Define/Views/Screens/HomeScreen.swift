//
//  HomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

// TODO: Time based UI needs to refresh

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
            title: "home_title",
            subtitle: "home_subtitle"
        )
        .stickyButton(
            title: "home_button",
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
                ListItem(word: word)
            }

        case .referenceLibrary:
            Button(action: {
                selectedWord = word
            }, label: {
                ListItem(word: word)
            })
        }
    }
}

// MARK: - ListItem

private struct ListItem: View, WordReminderObserver {

    @EnvironmentObject var words: WordsViewModel
    @State var isReminderScheduled = false // Protocol
    var word: SavedWord

    var body: some View {
        WordListItem(
            word: word.word,
            caption: word.addedSince,
            isScheduled: isReminderScheduled
        )
        .observeWordReminder(
            observer: self,
            word: word.word,
            words: words
        )
    }
}

// MARK: - Preview

#Preview {
    HomeScreen()
        .environmentObject(NavigationViewModel())
        .environmentObject(WordsViewModel())
}
