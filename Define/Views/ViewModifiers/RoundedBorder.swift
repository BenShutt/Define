//
//  RoundedBorder.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `ViewModifier` for rounded borders
struct RoundedBorder: ViewModifier {

    /// `Color` of the border
    var color: Color

    /// Apply overlay of stroked `RoundedRectangle`
    ///
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: .cornerRadius)
                .strokeBorder(color, lineWidth: .borderWidth)
            )
    }
}

// MARK: - View + RoundedBorder

extension View {

    /// Apply `RoundedBorder` `ViewModifier`
    /// 
    /// - Parameter color: `Color` of the border
    /// - Returns: `View`
    func roundedBorder(color: Color) -> some View {
        self.modifier(RoundedBorder(color: color))
    }
}
