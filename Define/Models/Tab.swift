//
//  Tab.swift
//  Define
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

enum Tab: Identifiable, CaseIterable {
    case home
    case info

    var id: Self { self }

    var title: LocalizedStringKey {
        switch self {
        case .home: "home_tab"
        case .info: "info_tab"
        }
    }

    var selectedSystemName: String {
        switch self {
        case .home: "house.fill"
        case .info: "info.circle.fill"
        }
    }

    var systemName: String {
        switch self {
        case .home: "house"
        case .info: "info.circle"
        }
    }

    @ViewBuilder var screen: some View {
        switch self {
        case .home: HomeScreen()
        case .info: InfoScreen()
        }
    }
}

// MARK: - TabModifier

private struct TabModifier: ViewModifier {
    var tab: Tab
    var isSelected: Bool

    func body(content: Content) -> some View {
        content
            .tabItem {
                Image(isSelected ? tab.selectedSystemName : tab.systemName)
                Text(tab.title)
            }
            .tag(tab)
    }
}

// MARK: - View + TabModifier

extension View {
    func tab(_ tab: Tab, isSelected: Bool) -> some View {
        modifier(TabModifier(tab: tab, isSelected: isSelected))
    }
}
