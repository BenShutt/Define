//
//  WordListItem.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Word`
struct WordListItem: View {
    @EnvironmentObject private var settings: UserSettings
    var word: Word

    var body: some View {
        if settings.wordsExpanded {
            ExpandedWordListItem(word: word)
        } else {
            CollapsedWordListItem(word: word.title)
        }
    }
}

// MARK: - CollapsedWordListItem

private struct CollapsedWordListItem: View {
    var word: String

    var body: some View {
        ListItem(
            title: word,
            leading: {},
            trailing: {
                ChevronView()
            }
        )
    }
}

// MARK: - ExpandedWordListItem

private struct ExpandedWordListItem: View {
    @EnvironmentObject private var words: WordsViewModel
    @State private var addedSince: LocalizedStringKey?
    var word: Word

    /// Are there any parts of speech
    private var hasCategories: Bool {
        !word.partsOfSpeech.isEmpty
    }

    /// Get the saved word, if exists
    private var savedWord: SavedWord? {
        words.words.first { $0.word == word }
    }

    var body: some View {
        HStack(spacing: .mediumLarge) {
            VStack(spacing: 0) {
                Text(verbatim: word.title)
                    .textStyle(.h3, fill: .leading)

                if let subtitle = word.subtitle {
                    Text(subtitle)
                        .textStyle(.body, lineLimit: 3, fill: .leading)
                        .padding(.top, .smallMedium)
                }

                if hasCategories {
                    PartsOfSpeechView(partsOfSpeech: word.partsOfSpeech)
                        .padding(.top, .mediumLarge)
                }

                if let addedSince {
                    Text(addedSince)
                        .textStyle(.caption, fill: .leading)
                        .padding(.top, .mediumLarge)
                }
            }

            ChevronView()
        }
        .overlay(alignment: .topTrailing) {
            if let savedWord {
                WordReminderView(savedWord: savedWord)
            }
        }
        .padding(.margins)
        .background(Color.appWhite)
        .onReceiveTimer {
            addedSince = savedWord?.addedSince
        }
    }
}

// MARK: - PartsOfSpeechView

private struct PartsOfSpeechView: View {
    var partsOfSpeech: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .small) {
                ForEach(partsOfSpeech, id: \.self) {
                    PartOfSpeechView(partOfSpeech: $0)
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    WordPreviewView(word: "hello") { word in
        WordListItem(word: word)
    }
    .screen()
    .environmentObjects()
}
