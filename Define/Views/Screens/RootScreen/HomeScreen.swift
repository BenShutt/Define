//
//  HomeScrollContent.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI
import SwiftData

/// Shorthand for an array of date groups of saved words
private typealias DateGroups = [DateGroup<SavedWord>]

/// View that is shown in a scroll view of the root screen
struct HomeScreen: View {
    @Environment(\.push) private var push
    var segmentedHeight: CGFloat

    /// Query the SwiftData database to get the saved words
    @Query(sort: \SavedWord.createdDate, order: .reverse) var words: [SavedWord]

    /// Group of the saved words by date
    @State private var groups: DateGroups = []

    /// Group the saved words loaded from the swift data database
    private func reload() {
        groups = DateGroup.group(words, by: \.createdDate)
    }

    var body: some View {
        RootNavigationScreen(
            segmentedHeight: segmentedHeight,
            subtitle: "home_subtitle",
            scrollContent: {
                HomeScrollContentView(groups: groups)
            }
        )
        .task { reload() }
        .onChange(of: words) { reload() }
        .stickyButton(
            title: "search_button",
            systemName: .magnifyingGlass,
            onTap: { push(.search) }
        )
    }
}

// MARK: - HomeScrollContentView

private struct HomeScrollContentView: View {
    var groups: DateGroups

    var body: some View {
        if groups.isEmpty {
            HomeEmptyView()
        } else {
            LazyVStack(spacing: .vMargin, pinnedViews: .sectionHeaders) {
                ForEach(groups) { group in
                    WordsSection(group: group)
                }
            }
            .padding(.vertical, .vMargin)
        }
    }
}

// MARK: - WordsSection

private struct WordsSection: View {
    @EnvironmentObject private var settings: UserSettings
    var group: DateGroup<SavedWord>

    var body: some View {
        Section(content: {
            ForEach(group.elements) { savedWord in
                WordListItemButton(
                    source: .saved(savedWord),
                    isExpanded: settings.wordsExpanded
                )
                .container()
                .padding(.horizontal, .hMargin)
            }
        }, header: {
            SectionHeader(title: group.title)
        })
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
    ScrollView {
        HomeScrollContentView(groups: [])
    }
    .screen()
    .environmentObjects()
}
