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

    /// `AppDelegate`
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    /// Storage of the `WordsViewModel` environment instance
    @StateObject private var words = WordsViewModel()

    /// Make `Scene`
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(words)
        }
    }
}
