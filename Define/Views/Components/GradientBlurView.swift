//
//  GradientBlurView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI
import Utilities

/// Blurred linear gradient
struct GradientBlurView: View {
    var color: Color = .default

    var body: some View {
        LinearGradient(
            colors: [
                .appWhite,
                color.opacity(0.2)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay {
            BlurView(style: .light)
        }
    }
}

// MARK: - Preview

#Preview {
    GradientBlurView()
}
