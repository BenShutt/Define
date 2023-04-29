//
//  CapsuleBorder.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI

/// `ViewModifier` for capsule borders
struct CapsuleBorder: ShapeBorder {

    /// `Color` of the border
    var color: Color

    /// `CGFloat` width of the border
    var borderWidth: CGFloat

    /// The shape to draw
    var shape: some InsettableShape {
        Capsule()
    }
}

// MARK: - View + CapsuleBorder

extension View {

    /// Capsule border
    /// - Parameters:
    ///   - color: `Color`
    ///   - borderWidth: `CGFloat`
    /// - Returns: `View
    func capsuleBorder(
        color: Color,
        borderWidth: CGFloat = .borderWidth
    ) -> some View {
        shapeBorder(CapsuleBorder(
            color: color,
            borderWidth: borderWidth
        ))
    }
}
