//
//  View+If.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

extension View {

    /// Implement a condtional modifier
    ///
    /// - Parameters:
    ///   - condition: Condtion of the `if` statement
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
