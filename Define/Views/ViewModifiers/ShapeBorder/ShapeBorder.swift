//
//  ShapeBorder.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI

/// A border driven by an `InsettableShape`
protocol ShapeBorder: ViewModifier {

    /// The `InsettableShape`
    associatedtype BorderShape: InsettableShape

    /// Stroked border color
    var color: Color { get }

    /// Width of the border
    var borderWidth: CGFloat { get }

    /// Make a new shape
    var shape: BorderShape { get }
}

// MARK: - ShapeBorder + ViewModifier

extension ShapeBorder {

    /// Apply overlay of stroked `shape`
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content
            .overlay(shape.strokeBorder(color, lineWidth: borderWidth))
            .clipShape(shape)
    }
}
