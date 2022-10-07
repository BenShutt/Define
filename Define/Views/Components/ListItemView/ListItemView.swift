//
//  ListItemView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

/// `ContentView` wrapped in a `Button`
struct ListItemView<ContentView: View>: View {

    /// Handle click events
    var onTap: () -> Void

    /// Build content view
    @ViewBuilder var content: () -> ContentView

    /// Draw `View`
    var body: some View {
        Button(action: onTap) {
            content()
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .buttonStyle(.borderless)
        .listRowInsets(.zero)
        .listRowSeparator(.automatic)
    }
}
