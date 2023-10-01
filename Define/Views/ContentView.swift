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
            RootView(hasWords: !words.isEmpty)
                .navigate()
        }
        .environmentObject(navigation)
        .environmentObject(words)
    }
}

// MARK: - RootView

/// Define the root UI
private struct RootView: View {

    /// Has the user seen the welcome screen.
    /// - Note Using `UserDefaults` directly rather than `@AppStorage` for static access
    private var hasSeenWelcome: Bool {
        get {
            UserDefaults.standard.value(for: .hasSeenWelcome) ?? false
        }
        set {
            UserDefaults.standard.set(newValue, for: .hasSeenWelcome)
        }
    }

    var hasWords: Bool

    var body: some View {
        if !hasSeenWelcome {
            WelcomeScreen()
        } else if hasWords {
            HomeScreen()
                .onAppear {
                    PushNotificationManager.requestRemoteNotificationPermission()
                }
        } else {
            SearchScreen()
                .onAppear {
                    PushNotificationManager.requestRemoteNotificationPermission()
                }
        }
    }
}
