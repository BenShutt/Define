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
struct HomeScrollContent: View {

    /// Query the SwiftData database to get the saved words
    @Query(sort: \SavedWord.createdDate, order: .reverse) var words: [SavedWord]

    /// Group of the saved words by date
    @State private var groups: DateGroups = []

    /// Group the saved words loaded from the swift data database
    private func reload() {
        groups = DateGroup.group(words, by: \.createdDate)
    }

    var body: some View {
        HomeScrollContentView(groups: groups)
            .task { reload() }
            .onChange(of: words) { reload() }
    }
}

// MARK: - HomeScrollContentView

private struct HomeScrollContentView: View {
    var groups: DateGroups

    var body: some View {
        if groups.isEmpty {
            HomeEmptyView()
        } else {
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                ForEach(groups) { group in
                    WordsSection(group: group)
                }
            }
            .marginedStack(.marginedStack)
        }
    }
}

// MARK: - WordsSection

private struct WordsSection: View {
    var group: DateGroup<SavedWord>

    var body: some View {
        Section(content: {
            ForEach(group.elements) { savedWord in
                WordListItemButton(source: .saved(savedWord))
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
    ScrollView {
        HomeScrollContent()
    }
    .screen()
    .environmentObjects()
}
