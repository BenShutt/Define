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

    /// The shape to draw
    var shape: some InsettableShape {
        Capsule()
    }
}

// MARK: - View + CapsuleBorder

extension View {

    /// Capsule border
    ///
    /// - Parameter color: `Color
    /// - Returns: `View`
    func capsuleBorder(color: Color) -> some View {
        shapeBorder(CapsuleBorder(color: color))
    }
}
