//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// Root app `View`
struct ContentView: View {

    /// `NavigationViewModel`
    @StateObject private var navigation = NavigationViewModel()

    /// `WordsViewModel`
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

    /// `Bool`
    var hasWords: Bool

    var body: some View {
        if hasWords {
            DefinitionsScreen()
        } else {
            SearchScreen()
        }
    }
}
