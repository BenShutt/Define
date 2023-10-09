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
    var title: String

    /// Optional text for the subtitle label
    var subtitle: String?

    /// Amount of padding
    var padding = EdgeInsets.header

    var body: some View {
        HeaderView(spacing: .medium, padding: padding) {
            Text(verbatim: title)
                .h1()

            if let subtitle {
                Text(verbatim: subtitle)
                    .body()
            }
        }
    }
}

// MARK: - PreviewProvider

struct HeaderView_Previews: PreviewProvider {

    static var previews: some View {
        TextHeaderView(
            title: .HomeScreen.title,
            subtitle: .HomeScreen.subtitle
        )
        .screen()
    }
}
