//
//  DefineApp.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import SwiftUI

/// Main `App` implementation
@main
struct DefineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var settings = UserSettings()
    @StateObject private var words = WordsViewModel() // TODO: Rename
    @StateObject private var notifications = NotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environmentObject(words)
                .environmentObject(notifications)
        }
    }
}

// MARK: - View + EnvironmentObjects

extension View {
    @MainActor func environmentObjects() -> some View {
        environmentObject(UserSettings())
            .environmentObject(WordsViewModel())
            .environmentObject(NotificationManager())
    }
}
