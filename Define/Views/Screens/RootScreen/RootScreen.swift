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

    @MainActor
    @ViewBuilder func screen(segmentedHeight: CGFloat) -> some View {
        switch self {
        case .home: HomeScreen(segmentedHeight: segmentedHeight)
        case .info: InfoScreen(segmentedHeight: segmentedHeight)
        }
    }
}

// MARK: - RootScreen

struct RootScreen: View {
    @State private var selectedSegment: RootSegment = .home
    @State private var segmentedHeight: CGFloat = 0

    var body: some View {
        TabView(selection: $selectedSegment) {
            ForEach(RootSegment.allCases) { segment in
                segment
                    .screen(segmentedHeight: segmentedHeight)
                    .tag(segment)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea(edges: [.top, .bottom])
        .screen()
        .overlay(alignment: .top) {
            SegmentedControl(
                selectedSegment: $selectedSegment,
                segments: RootSegment.allCases
            )
            .padding(.margins)
            .onSizeChange { segmentedHeight = $0.height }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - RootNavigationScreen

struct RootNavigationScreen<Content: View>: View {
    @State private var subtitleHeight: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    var segmentedHeight: CGFloat
    var subtitle: LocalizedStringKey
    var scrollContent: () -> Content

    var body: some View {
        OffsetScrollView(onOffsetChange: {
            offsetY = $0.y
        }, content: {
            scrollContent()
                .padding(.top, subtitleHeight)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, segmentedHeight)
        .overlay(alignment: .top) {
            NavigationBarSubtitle(
                subtitleHeight: $subtitleHeight,
                offsetY: offsetY,
                subtitle: subtitle
            )
            .padding(.top, segmentedHeight)
            .background {
                NavigationBarBackground()
                    .ignoresSafeArea(edges: .top)
            }
        }
    }
}

// MARK: - NavigationBarSubtitle

private struct NavigationBarSubtitle: View {
    @Binding var subtitleHeight: CGFloat
    var offsetY: CGFloat
    var subtitle: LocalizedStringKey

    /// Value in `[0, 1]`.
    /// Progress from not scrolled to fully scrolled (respectively)
    private var progress: CGFloat {
        guard subtitleHeight > 0 else { return 1 }
        return (offsetY / subtitleHeight).clamped(to: 0...1)
    }

    /// Value in `[0, 1]`.
    /// Opacity of the navigation bar subtitle as a function of progress
    /// - Note: Resolves at 2x the rate of progress
    private var subtitleOpacity: CGFloat {
        (1 - 2 * progress).clamped(to: 0...1)
    }

    /// Value in `[-subtitleHeight, 0]`.
    /// Offset in Y of the navigation bar subtitle as a function of progress
    private var subtitleOffset: CGFloat {
        (-offsetY).clamped(to: -subtitleHeight...0)
    }

    var body: some View {
        Text(subtitle)
            .textStyle(.body, fill: .leading)
            .padding(.horizontal, .hMargin)
            .padding(.bottom, .vMargin)
            .onSizeChange { subtitleHeight = $0.height }
            .opacity(subtitleOpacity)
            .offset(y: subtitleOffset)
            .clippedHeight {
                $0 + subtitleOffset
            }
    }
}

// MARK: - CGFloat + Extensions

extension CGFloat {
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
    }
}
