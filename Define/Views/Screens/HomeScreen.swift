//
//  HomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct HomeScreen: View {

    /// Map `DateGroup` to its `SavedWord`s
    typealias DateGroups = [(group: DateGroup, savedWords: [SavedWord])]

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// The word to show in a presented reference library modal
    @State private var selectedWord: SavedWord?

    /// Group words into groups by date
    private var groups: DateGroups {
        DateGroup.group(words.words, keyPath: \.savedDate)
    }

    var body: some View {
        NavigationScreen(
            title: "home_title",
            subtitle: "home_subtitle"
        ) {
            LazyVStack(spacing: 0) {
                ForEach(groups, id: \.0) { group, savedWords in
                    WordsGroup(
                        selectedWord: $selectedWord,
                        group: group,
                        savedWords: savedWords
                    )
                }
            }
            .marginedStack(.margins)
        }
        .stickyButton(
            title: "home_button",
            systemName: "magnifyingglass"
        ) {
            navigation.push(.search)
        }
        .sheet(item: $selectedWord) { savedWord in
            ReferenceLibraryScreen(term: savedWord.word.word) {
                selectedWord = nil
            }
        }
    }
}

// MARK: - WordSection

private struct WordsGroup: View {

    @Binding var selectedWord: SavedWord?
    var group: DateGroup
    var savedWords: [SavedWord]

    var body: some View {
        Text(group.title)
            .h2()
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, .hMargin)
            .padding(.top, .large)

        ForEach(savedWords) { savedWord in
            WordRow(
                selectedWord: $selectedWord,
                word: savedWord
            )
            .margined(.margins)
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

private struct ListItem: View {

    @EnvironmentObject var words: WordsViewModel
    @State private var addedSince: LocalizedStringKey?
    @State private var isReminderScheduled = false
    var word: SavedWord

    var body: some View {
        WordListItem(
            word: word.word,
            caption: addedSince,
            isScheduled: isReminderScheduled
        )
        .onReceiveTimer {
            addedSince = word.addedSince
        }
        .modifier(WordReminderObserver(
            isReminderScheduled: $isReminderScheduled,
            word: word.word
        ))
    }
}

// MARK: - Preview

#Preview {
    HomeScreen()
        .environmentObject(NavigationViewModel())
        .environmentObject(WordsViewModel())
}
