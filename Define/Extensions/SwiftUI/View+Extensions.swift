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

    /// Configure for list item
    func listItem() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
    }

    /// Implement a conditional modifier
    ///
    /// - Parameters:
    ///   - condition: Condition of the `if` statement
    ///   - transform: Mapping of `self` to some `View`
    /// - Returns: `View`
    @ViewBuilder func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
