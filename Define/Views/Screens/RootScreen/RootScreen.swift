//
//  RootScreen.swift
//  Define
//
//  Created by Ben Shutt on 29/06/2024.
//

import SwiftUI

// MARK: - RootSegment

enum RootSegment: Identifiable, Equatable, CaseIterable, SegmentedItem {
    case home
    case info

    var id: Self { self }

    var title: LocalizedStringKey {
        switch self {
        case .home: "home_title"
        case .info: "info_title"
        }
    }

    var subtitle: LocalizedStringKey {
        switch self {
        case .home: "home_subtitle"
        case .info: "info_subtitle \(appNameOrDefault)"
        }
    }

    @ViewBuilder var scrollContent: some View {
        switch self {
        case .home: HomeScrollContent()
        case .info:  InfoScrollContent()
        }
    }
}

// MARK: - RootScreen

struct RootScreen: View {
    @Environment(\.push) private var push

    @State private var offsetY: CGFloat = 0
    @State private var selectedSegment: RootSegment = .home
    @State private var segmentedHeight: CGFloat = 0
    @State private var descriptionHeight: CGFloat = 0

    var body: some View {
        OffsetScrollView(
            onOffsetChange: { offsetY = $0.y },
            content: {
                selectedSegment.scrollContent
                    .padding(.top, descriptionHeight)
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, segmentedHeight)
        .overlay(alignment: .top) {
            RootNavigationBar(
                offsetY: offsetY,
                selectedSegment: $selectedSegment,
                segmentedHeight: $segmentedHeight,
                descriptionHeight: $descriptionHeight
            )
        }
        .screen()
        .toolbar(.hidden, for: .navigationBar)
        .stickyBottom {
            if selectedSegment == .home {
                StyledButton(
                    title: "search_button",
                    systemName: "magnifyingglass",
                    onTap: { push(.search) }
                )
                .padding(.margins)
            }

            // TODO: Info bottom
        }
    }
}

// MARK: - RootNavigationBar

private struct RootNavigationBar: View {
    var offsetY: CGFloat
    @Binding var selectedSegment: RootSegment
    @Binding var segmentedHeight: CGFloat
    @Binding var descriptionHeight: CGFloat

    /// Value in `[0, 1]`.
    /// Progress from not scrolled to fully scrolled (respectively)
    private var progress: CGFloat {
        max(0, min(1, offsetY / descriptionHeight))
    }

    /// Value in `[0, 1]`.
    /// Opacity of the navigation bar description as a function of progress
    /// - Note: Resolves at 2x the rate of progress
    private var descriptionOpacity: CGFloat {
        max(0, 1 - 2 * progress)
    }

    /// Value in `[-descriptionHeight, 0]`.
    /// Offset in Y of the navigation bar description as a function of progress
    private var descriptionOffset: CGFloat {
        max(-descriptionHeight, min(0, -offsetY))
    }

    var body: some View {
        VStack(spacing: 0) {
            SegmentedControl(
                selectedSegment: $selectedSegment,
                segments: RootSegment.allCases
            )
            .padding(.vertical, .vMargin)
            .onSizeChanged { segmentedHeight = $0.height }

            Text(selectedSegment.subtitle)
                .textStyle(.body, fill: .leading)
                .padding(.bottom, .vMargin)
                .onSizeChanged { descriptionHeight = $0.height }
                .opacity(descriptionOpacity)
                .offset(y: descriptionOffset)
                .clippedHeight {
                    $0 + descriptionOffset
                }
        }
        .padding(.horizontal, .hMargin)
        .background {
            NavigationBarBackground()
                .ignoresSafeArea(edges: .top)
        }
    }
}
