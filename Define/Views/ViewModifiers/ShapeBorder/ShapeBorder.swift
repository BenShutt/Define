//
//  ShapeBorder.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// A border driven by an `InsettableShape`
protocol ShapeBorder: ViewModifier {

    /// The `InsettableShape`
    associatedtype BorderShape: InsettableShape

    /// Stroked border color
    var color: Color { get }

    /// Make a new shape
    var shape: BorderShape { get }
}

// MARK: - ShapeBorder + ViewModifier

extension ShapeBorder {

    /// Apply overlay of stroked `RoundedRectangle`
    ///
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content
            .overlay(
                shape
                    .strokeBorder(color, lineWidth: .borderWidth)
            )
            .clipShape(shape)
    }
}

// MARK: - View + ShapeBorder

extension View {

    /// Apply `ShapeBorder` `ViewModifier`
    ///
    /// - Parameter border: `Border`
    /// - Returns: `View`
    func shapeBorder<Border: ShapeBorder>(_ border: Border) -> some View {
        self.modifier(border)
    }

    /// Default shape border
    ///
    /// - Parameter color: `Color
    /// - Returns: `View`
    func shapeBorder(color: Color) -> some View {
        shapeBorder(CapsuleBorder(color: color))
    }
}
