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
    @Environment(\.push) private var push

    var body: some View {
        HomeContentView()
            .screen()
            .stickyButton(
                title: "search_button",
                systemName: "magnifyingglass",
                onTap: { push(.search) }
            )
    }
}

// MARK: - HomeContentView

private struct HomeContentView: View {
    @EnvironmentObject private var words: WordsViewModel

    /// Group words into groups by date
    private var groups: DateGroups { // TODO: Performance, add to view-model
        DateGroup.group(words.words, keyPath: \.savedDate)
    }

    var body: some View {
        if groups.isEmpty {
            HomeEmptyView()
        } else {
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

// MARK: - HomeEmptyView

struct HomeEmptyView: View {
    var body: some View {
        SearchEmptyView(
            lottie: .searchNoResults,
            title: "home_empty_title",
            subtitle: "home_empty_subtitle"
        )
    }
}

// MARK: - Preview

#Preview {
    HomeScreen()
        .environmentObjects()
}
