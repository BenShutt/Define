//
//  HomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct HomeScreen: View {
    @EnvironmentObject private var words: WordsViewModel
    @Environment(\.push) private var push

    /// The word to show in a presented reference library modal
    @State private var selectedWord: SavedWord?

    /// Group words into groups by date
    private var groups: DateGroups { // TODO: Performance, add to view-model
        DateGroup.group(words.words, keyPath: \.savedDate)
    }

    var body: some View {
        NavigationScreen(
            title: "home_title",
            subtitle: "home_subtitle"
        ) {
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                ForEach(groups, id: \.0) { group, savedWords in
                    WordsSection(
                        selectedWord: $selectedWord,
                        group: group,
                        savedWords: savedWords
                    )
                }
            }
            .marginedStack(.marginedStack)
        }
        .stickyButton(
            title: "home_button",
            systemName: "magnifyingglass"
        ) {
            push(.search)
        }
        .sheet(item: $selectedWord) { savedWord in
            ReferenceLibraryScreen(term: savedWord.word.word) {
                selectedWord = nil
            }
        }
    }
}

// MARK: - WordsSection

private struct WordsSection: View {
    @Binding var selectedWord: SavedWord?
    var group: DateGroup
    var savedWords: [SavedWord]

    var body: some View {
        Section(content: {
            ForEach(savedWords) { savedWord in
                WordRow(
                    selectedWord: $selectedWord,
                    word: savedWord
                )
                .margined(.marginedStack)
            }
        }, header: {
            WordsSectionHeader(title: group.title)
        })
    }
}

// MARK: - WordsSectionHeader

private struct WordsSectionHeader: View {
    var title: LocalizedStringKey
    private let separatorColor: Color = .appGray.opacity(0.1)

    var body: some View {
        HStack(spacing: .extraLarge) {
            Separator(color: separatorColor)
                .frame(minWidth: .hMargin, maxWidth: .infinity)

            Text(title)
                .textStyle(.h4)

            Separator(color: separatorColor)
                .frame(minWidth: .hMargin, maxWidth: .infinity)
        }
        .padding(.horizontal, .hMargin)
        .padding(.vertical, .smallMedium)
        .background(Color.screenBackground)
    }
}

// MARK: - WordRow

private struct WordRow: View {
    @Environment(\.push) private var push
    @Binding var selectedWord: SavedWord?
    var word: SavedWord

    var body: some View {
        switch word.source {
        case .api:
            Button(action: {
                push(.word(word.word))
            }, label: {
                ListItem(word: word)
            })

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
    @State private var addedSince: LocalizedStringKey? // TODO: View model?
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
        .environmentObject(WordsViewModel())
}
