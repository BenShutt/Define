//
//  View+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

extension View {

    /// Configure for list item
    func listItem() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
    }

    /// Wrap in a margined container
    /// - Parameter margins: `EdgeInsets`
    /// - Returns: `View`
    func margined(_ margins: EdgeInsets) -> some View {
        self.cornerRadius(.cornerRadius)
            .shadow(.container)
            .padding(margins)
    }

    /// Apply padding to a stack containing margined cells
    /// - Parameter margins: `EdgeInsets`
    /// - Returns: `View`
    func marginedStack(_ margins: EdgeInsets) -> some View {
        self.padding(.top, margins.top)
            .padding(.bottom, margins.bottom)
    }
}
