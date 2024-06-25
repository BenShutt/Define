//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

// TODO: Add info page (possibly a tab)
// Version, Rate, Report, Donate, Export, Color Scheme?

/// Root app `View`
struct ContentView: View {
    var body: some View {
        RootNavigationStack {
            RootView()
        }
    }
}

// MARK: - RootView

/// Define the root UI
private struct RootView: View {
    @EnvironmentObject private var words: WordsViewModel
    @Environment(\.push) private var push

    /// Has the user seen the welcome screen
    @AppStorage(UserDefaultKey.hasSeenWelcome.rawValue) private var hasSeenWelcome = false

    var body: some View {
        Group {
            if !hasSeenWelcome {
                WelcomeScreen {
                    hasSeenWelcome = true
                    push(.search)
                    PushNotificationManager.requestRemoteNotificationPermission()
                }
            } else if !words.isEmpty {
                HomeScreen()
            } else {
                SearchScreen()
            }
        }
        .onReminderDidReceive(words: words) { word in
            push(.word(word))
        }
    }
}
