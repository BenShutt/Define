//
//  WordListItem.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import DictionaryAPI

struct WordListItemButton: View {
    @Environment(\.push) private var push

    var source: WordSource
    var isExpanded: Bool
    var showSaved: Bool

    var body: some View {
        Button(action: {
            push(.word(source))
        }, label: {
            WordListItem(
                source: source,
                isExpanded: isExpanded,
                showSaved: showSaved
            )
        })
    }
}

// MARK: - WordListItem

private struct WordListItem: View {
    var source: WordSource
    var isExpanded: Bool
    var showSaved: Bool

    var body: some View {
        if isExpanded {
            ExpandedWordListItem(source: source, showSaved: showSaved)
        } else {
            CollapsedWordListItem(title: source.word.title)
        }
    }
}

// MARK: - CollapsedWordListItem

private struct CollapsedWordListItem: View {
    var title: String

    var body: some View {
        ListItem(
            title: title,
            leading: {},
            trailing: {
                ChevronView()
            }
        )
    }
}

// MARK: - ExpandedWordListItem

private struct ExpandedWordListItem: View {
    var source: WordSource
    var showSaved: Bool

    var body: some View {
        VStack(spacing: 0) {
            if showSaved, source.isSaved {
                WordSavedView(padding: .init(
                    vertical: .smallMedium,
                    horizontal: .hMargin
                ))
            }

            WordListItemContentView(source: source)
        }
        .background(Color.appWhite)
    }
}

// MARK: - WordListItemContentView

private struct WordListItemContentView: View {
    @State private var addedSince: LocalizedStringKey?

    var source: WordSource

    private var partsOfSpeech: [String] {
        source.word.partsOfSpeech
    }

    var body: some View {
        HStack(spacing: .mediumLarge) {
            VStack(spacing: 0) {
                Text(verbatim: source.word.title)
                    .textStyle(.h3, fill: .leading)

                if let subtitle = source.word.subtitle {
                    Text(subtitle)
                        .textStyle(.body, lineLimit: 3, fill: .leading)
                        .padding(.top, .smallMedium)
                }

                if !partsOfSpeech.isEmpty {
                    PartsOfSpeechView(partsOfSpeech: partsOfSpeech)
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
            if let savedWord = source.savedWord {
                WordReminderView(savedWord: savedWord)
            }
        }
        .padding(.margins)
        .onReceiveTimer {
            addedSince = source.savedWord?.addedSince
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
        WordListItemButton(
            source: .api(word),
            isExpanded: true,
            showSaved: true
        )
    }
    .screen()
    .environmentObjects()
}
