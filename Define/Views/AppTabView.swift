//
//  AppTabView.swift
//  Define
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTab: Tab = .home

    init() {
        TabAppearance.setup()
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases) { tab in
                RootNavigationStack {
                    tab.screen
                        .observeTabRequests(tab: tab)
                }
                .tab(tab)
            }
        }
        .observeRootTabRequests(selectedTab: $selectedTab)
        .routeWordReminders()
    }
}
