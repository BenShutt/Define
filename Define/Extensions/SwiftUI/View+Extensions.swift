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
}
