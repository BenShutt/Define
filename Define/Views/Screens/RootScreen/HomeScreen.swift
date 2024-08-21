//
//  HomeScrollContent.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI
import SwiftData
import FlowLayout

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
                    Section(content: {
                        WordsSection(words: group.elements)
                    }, header: {
                        SectionHeader(title: group.title)
                    })
                }
            }
            .padding(.margins)
        }
    }
}

// MARK: - WordsSection

private struct WordsSection: View {
    @EnvironmentObject private var settings: UserSettings
    var words: [SavedWord]

    var body: some View {
        if settings.wordsExpanded {
            ForEach(words) { savedWord in
                WordListItemButton(
                    source: .saved(savedWord),
                    showSaved: false
                )
                .container()
            }
        } else {
            FlowLayoutView(words.map { word in
                WordTagView(word: word)
            }, configuration: .init(
                hSpacing: .medium,
                vSpacing: .small
            ))
        }
    }
}

// MARK: - WordTagView

private struct WordTagView: View, FlowLayoutSized {
    @Environment(\.push) private var push
    var word: SavedWord

    private var tagView: TagView {
        TagView(
            title: word.model.title,
            foregroundColor: .appBlack,
            backgroundColor: .appWhite
        )
    }

    var body: some View {
        Button(action: {
            push(.word(.saved(word)))
        }, label: {
            tagView
        })
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: FlowLayoutSized

    func size(in boundsSize: CGSize) -> CGSize {
        tagView.size(in: boundsSize)
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
