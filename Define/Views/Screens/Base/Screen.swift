//
//  Screen.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import SwiftUI

/// An app screen
protocol Screen: View {

    /// Some `View`
    associatedtype Content: View

    /// Get the `NavigationBarStyle`
    var navigationBarStyle: NavigationBarStyle { get }

    /// The screens implementation of `body`
    @ViewBuilder var screen: Content { get }
}

// MARK: - Extensions

extension Screen {

    /// By default, return `.white`
    var navigationBarStyle: NavigationBarStyle {
        .white
    }

    /// The `View` of the screen
    var body: some View {
        ZStack {
            Color.appWhite
                .ignoresSafeArea()
            screen
        }
        .toolbarBackground(navigationBarStyle.backgroundColor, for: .navigationBar)
        .toolbarBackground(navigationBarStyle.backgroundVisibility, for: .navigationBar)
        .navigationBarTitleDisplayMode(navigationBarStyle.titleDisplayMode)
    }
}
