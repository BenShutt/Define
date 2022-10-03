//
//  CapsuleBorder.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
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
