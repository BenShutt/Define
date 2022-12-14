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

    /// The `View` of the screen
    var body: some View {
        ScreenBody(content: { screen })
            .navigationBarStyle(navigationBarStyle)
    }
}
