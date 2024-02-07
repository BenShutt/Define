//
//  HeaderView.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// Container of vertically stacked header UI
struct HeaderView<Content: View>: View {

    /// Vertical stack spacing
    var spacing: CGFloat

    /// Amount of padding
    var padding = EdgeInsets.header

    /// Subview content
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content()
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(padding)
        .background {
            HeaderBackground()
        }
    }
}

// MARK: - HeaderBackground

struct HeaderBackground: View {

    var body: some View {
        GradientBlurView(color: .appBlue)
            .ignoresSafeArea()
            .compositingGroup()
            .shadow(.sticky)
    }
}
