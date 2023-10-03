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
    @StateObject private var navigation: NavigationViewModel = .shared

    /// Storage of the `WordsViewModel` environment instance
    @StateObject private var words = WordsViewModel()

    /// Root `NavigationStack`
    var body: some View {
        NavigationStack(path: $navigation.path) {
            RootView()
                .navigate()
        }
        .environmentObject(navigation)
        .environmentObject(words)
    }
}

// MARK: - RootView

/// Define the root UI
private struct RootView: View {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Has the user seen the welcome screen
    @AppStorage(UserDefaultKey.hasSeenWelcome.rawValue) var hasSeenWelcome = false

    var body: some View {
        if !hasSeenWelcome {
            WelcomeScreen {
                hasSeenWelcome = true
                navigation.push(.search)
                PushNotificationManager.requestRemoteNotificationPermission()
            }
        } else if !words.isEmpty {
            HomeScreen()
        } else {
            SearchScreen()
        }
    }
}
