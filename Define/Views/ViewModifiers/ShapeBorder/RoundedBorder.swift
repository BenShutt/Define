//
//  RoundedBorder.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// `ViewModifier` for rounded borders
struct RoundedBorder: ShapeBorder {

    /// `Color` of the border
    var color: Color

    /// Radius of the rounded corner
    var cornerRadius: CGFloat

    /// The shape to draw
    var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: cornerRadius)
    }
}
