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
            navigation.rootView(words: words)
        }
        .environmentObject(navigation)
        .environmentObject(words)
    }
}
