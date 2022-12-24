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
    @StateObject var navigation = NavigationViewModel()

    /// Root `NavigationStack`
    var body: some View {
        NavigationStack(path: $navigation.path) {
            navigation.rootView
        }
        .environmentObject(navigation)
    }
}
