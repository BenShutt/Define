//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// Root app `View`
struct ContentView: View {

    /// Storage of the `NavigationViewModel` environment instance
    @StateObject private var navigation = NavigationViewModel()

    /// Storage of the `WordsViewModel` environment instance
    @StateObject private var words = WordsViewModel()

    /// Root `NavigationStack`
    var body: some View {
        NavigationStack(path: $navigation.path) {
            RootView(hasWords: !words.isEmpty)
                .navigate()
        }
        .onAppear {
            PushNotificationManager.requestRemoteNotificationPermission()
        }
        .environmentObject(navigation)
        .environmentObject(words)
    }
}

// MARK: - RootView

/// Define the root UI
private struct RootView: View {

    var hasWords: Bool

    var body: some View {
        if hasWords {
            HomeScreen()
        } else {
            SearchScreen()
        }
    }
}
