//
//  NavigationBarStyle.swift
//  Define
//
//  Created by Ben Shutt on 04/01/2023.
//

import SwiftUI

/// Style-able properties for the navigation bar
struct NavigationBarStyle {

    /// Navigation title text
    var title: String

    /// Navigation bar background color
    var backgroundColor: Color = .appWhite

    /// Title display mode
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode = .automatic
}

// MARK: - Constants

extension NavigationBarStyle {

    /// Clear style
    static let clear = NavigationBarStyle(
        title: "",
        backgroundColor: .clear,
        titleDisplayMode: .inline
    )
}

// MARK: - ViewModifier

extension NavigationBarStyle: ViewModifier {

    /// Configure navigation bar style
    ///
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content
            .toolbarBackground(backgroundColor, for: .navigationBar)
            .navigationBarTitleDisplayMode(titleDisplayMode)
            .if(!title.isEmpty) {
                $0.navigationTitle(title)
            }
    }
}

// MARK: View + NavigationBarStyle

extension View {

    /// Add `NavigationBarStyle` modifier
    /// - Parameter navigationBarStyle: `NavigationBarStyle`
    /// - Returns: `View`
    func navigationBarStyle(_ navigationBarStyle: NavigationBarStyle) -> some View {
        modifier(navigationBarStyle)
    }
}
