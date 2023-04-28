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

    /// Color for gradient
    var color: Color

    /// Amount of top padding
    var topPadding: CGFloat = .headerPadding

    /// Subview content
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content()
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .trailing, .bottom], .headerPadding)
        .padding(.top, topPadding)
        .background {
            GradientBlurView(color: color)
                .ignoresSafeArea()
                .shadow(.sticky)
        }
    }
}
