//
//  Screen.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import SwiftUI

/// An app screen
private struct Screen: ViewModifier {
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
    func screen(backgroundColor: Color = .screenBackground) -> some View {
        modifier(Screen(backgroundColor: backgroundColor))
    }
}
