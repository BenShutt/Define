//
//  TextHeaderView.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// Header view with text
struct TextHeaderView: View {

    /// Text for the title label
    var title: LocalizedStringKey

    /// Optional text for the subtitle label
    var subtitle: LocalizedStringKey?

    /// Amount of padding
    var padding = EdgeInsets.header

    var body: some View {
        HeaderView(spacing: .medium, padding: padding) {
            Text(title)
                .h1()

            if let subtitle {
                Text(subtitle)
                    .body()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TextHeaderView(
        title: "Preview Title",
        subtitle: "Preview subtitle"
    )
    .screen()
}
