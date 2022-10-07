//
//  View+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

extension View {

    /// Apply app standard shadow
    func appShadow() -> some View {
        shadow(color: .appShadow, radius: .shadowRadius, x: 0, y: 0)
    }

    /// Set frame with the fixed `size`
    /// - Parameter size: `CGFloat`
    /// - Returns: `View`
    func frame(_ size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
}
