//
//  Screen.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import SwiftUI

// MARK: - Screen

/// An app screen
/// - Note: The reason for a `ViewModifier` over a protocol is we might want to add
/// properties before or after
private struct Screen: ViewModifier {

    /// Screen background color
    var backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                backgroundColor
                    .ignoresSafeArea()
            }
    }
}

// MARK: - View + Screen

extension View {
    func screen(backgroundColor: Color = .appLightGray) -> some View {
        modifier(Screen(backgroundColor: backgroundColor))
    }
}
