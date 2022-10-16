//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// Root app `View`
struct ContentView: View {

    /// Root `NavigationStack`
    var body: some View {
        NavigationStack {
            SearchScreen()
        }
    }
}
