//
//  HomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

// TODO: Add collapsable UI

/// Screen listing the user's saved definitions
struct HomeScreen: View {
    @EnvironmentObject private var words: WordsViewModel
    @Environment(\.push) private var push

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
    }
}

// MARK: - WordsSection

private struct WordsSection: View {
    @Environment(\.push) private var push
    var group: DateGroup
    var savedWords: [SavedWord]

    var body: some View {
        Section(content: {
            ForEach(savedWords) { savedWord in
                Button(action: {
                    push(.word(savedWord.word))
                }, label: {
                    WordListItem(word: savedWord.word)
                })
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

// MARK: - Preview

#Preview {
    HomeScreen()
        .environmentObjects()
}
