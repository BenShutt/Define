//
//  RootScreen.swift
//  Define
//
//  Created by Ben Shutt on 29/06/2024.
//

import SwiftUI

enum RootSegment: Identifiable, Equatable, CaseIterable, SegmentedItem {
    case home
    case info

    var id: Self { self }

    var title: LocalizedStringKey {
        switch self {
        case .home: "home_title"
        case .info:  "info_title"
        }
    }

    var subtitle: LocalizedStringKey {
        switch self {
        case .home: "home_subtitle"
        case .info:  "info_subtitle \(appNameOrDefault)"
        }
    }

    @ViewBuilder var screen: some View {
        switch self {
        case .home: HomeScreen()
        case .info:  InfoScreen()
        }
    }
}

struct RootScreen: View {
    @State private var selectedSegment: RootSegment = .home

    var body: some View {
        NavigationScreen(
            title: selectedSegment.title,
            subtitle: selectedSegment.subtitle
        ) {
            SegmentedControl(
                selectedSegment: $selectedSegment,
                segments: RootSegment.allCases
            )

            selectedSegment.screen
        }
        .screen()
    }
}
