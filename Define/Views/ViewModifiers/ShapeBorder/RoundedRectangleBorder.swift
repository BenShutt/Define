//
//  RoundedRectangleBorder.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI

/// `ViewModifier` for rounded rectangle borders
struct RoundedRectangleBorder: ShapeBorder {

    /// `Color` of the border
    var color: Color

    /// `CGFloat` radius of the corners
    var cornerRadius: CGFloat

    /// `CGFloat` width of the border
    var borderWidth: CGFloat

    /// The shape to draw
    var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: cornerRadius)
    }
}

// MARK: - View + RoundedRectangleBorder

extension View {

    /// Rounded rectangle border
    /// - Parameters:
    ///   - color: `Color`
    ///   - cornerRadius: `CGFloat`
    ///   - borderWidth: `CGFloat`
    /// - Returns: `View
    func roundedRectangleBorder(
        color: Color,
        cornerRadius: CGFloat = .cornerRadius,
        borderWidth: CGFloat = .borderWidth
    ) -> some View {
        self.modifier(RoundedRectangleBorder(
            color: color,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth
        ))
    }
}
