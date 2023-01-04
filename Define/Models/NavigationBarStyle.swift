//
//  NavigationBarStyle.swift
//  Define
//
//  Created by Ben Shutt on 04/01/2023.
//

import SwiftUI

/// Style-able properties for the navigation bar
struct NavigationBarStyle {

    /// Navigation bar background color
    var backgroundColor: Color

    /// Navigation bar background visibility
    var backgroundVisibility: Visibility

    /// Title display mode
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode
}

// MARK: - Styles

extension NavigationBarStyle {

    /// White style
    static let white = NavigationBarStyle(
        backgroundColor: .appWhite,
        backgroundVisibility: .automatic,
        titleDisplayMode: .automatic
    )

    /// Clear style
    static let clear = NavigationBarStyle(
        backgroundColor: .clear,
        backgroundVisibility: .hidden,
        titleDisplayMode: .inline
    )
}
