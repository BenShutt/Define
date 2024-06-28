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
            VStack(spacing: .small) {
                Text(verbatim: word.title)
                    .textStyle(.h3, fill: .leading)
                    .padding(.bottom, .small)

                if let subtitle = word.subtitle {
                    Text(subtitle)
                        .textStyle(.body, lineLimit: 3, fill: .leading)
                }

                if let addedSince {
                    Text(addedSince)
                        .textStyle(.caption, fill: .leading)
                }

                if hasCategories {
                    PartsOfSpeechView(partsOfSpeech: word.partsOfSpeech)
                        .padding(.top, .medium)
                }
            }

            ChevronView()
        }
        .overlay(alignment: .topTrailing) {
            if let savedWord {
                WordReminderView(savedWord: savedWord)
            }
        }
        .padding(.large)
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
        .scrollBounceBasedOnSize()
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    WordListItem(word: .preview)
        .screen()
        .environmentObjects()
}
