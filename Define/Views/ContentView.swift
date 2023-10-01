//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// Root app `View`
struct ContentView: View {

    /// Has the user seen the welcome screen.
    /// - Note Using `UserDefaults` directly rather than `@AppStorage` for static access
    private static var hasSeenWelcome: Bool {
        get {
            UserDefaults.standard.value(for: .hasSeenWelcome) ?? false
        }
        set {
            UserDefaults.standard.set(newValue, for: .hasSeenWelcome)
        }
    }

    /// Storage of the `NavigationViewModel` environment instance
    @StateObject private var navigation: NavigationViewModel = .shared

    /// Storage of the `WordsViewModel` environment instance
    @StateObject private var words = WordsViewModel()

    /// Are we presenting the welcome screen
    @State private var isPresentingWelcome = !hasSeenWelcome

    /// Root `NavigationStack`
    var body: some View {
        NavigationStack(path: $navigation.path) {
            RootView(hasWords: !words.isEmpty)
                .navigate()
                .onAppear {
                    guard Self.hasSeenWelcome else { return }
                    PushNotificationManager.requestRemoteNotificationPermission()
                }
        }
        .sheet(
            isPresented: $isPresentingWelcome,
            onDismiss: {
                Self.hasSeenWelcome = true
                PushNotificationManager.requestRemoteNotificationPermission()
            }, content: {
                WelcomeScreen()
            }
        )
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
