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

    @StateObject private var words = WordsViewModel() // TODO: Rename
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var tabRequestPublisher = TabRequestPublisher()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(words)
                .environmentObject(notificationManager)
                .environmentObject(tabRequestPublisher)
        }
    }
}

// MARK: - View + EnvironmentObjects

extension View {
    @MainActor func environmentObjects() -> some View {
        self.environmentObject(WordsViewModel())
            .environmentObject(NotificationManager())
            .environmentObject(TabRequestPublisher())
    }
}
