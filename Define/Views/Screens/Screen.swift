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

    /// The screens implementation of `body`
    @ViewBuilder var screenBody: ScreenBody { get }
}

// MARK: - Extensions

extension Screen {

    /// The `View` of the screen
    var body: some View {
        ZStack {
            Color.appWhite
                .ignoresSafeArea()
            screenBody
        }
    }
}
