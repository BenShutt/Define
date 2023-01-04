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
    associatedtype ScreenBody: View

    /// Get the `NavigationBarStyle`
    var navigationBarStyle: NavigationBarStyle { get }

    /// The screens implementation of `body`
    @ViewBuilder var screenBody: ScreenBody { get }
}

// MARK: - Extensions

extension Screen {

    /// By default, return `.automatic`
    var navigationBarStyle: NavigationBarStyle {
        .white
    }

    /// The `View` of the screen
    var body: some View {
        ZStack {
            Color.appWhite
                .ignoresSafeArea()
            screenBody
        }
        .toolbarBackground(navigationBarStyle.backgroundColor, for: .navigationBar)
        .toolbarBackground(navigationBarStyle.backgroundVisibility, for: .navigationBar)
        .navigationBarTitleDisplayMode(navigationBarStyle.titleDisplayMode)
    }
}
