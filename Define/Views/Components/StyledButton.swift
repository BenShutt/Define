//
//  StyledButton.swift
//  Define
//
//  Created by Ben Shutt on 01/10/2022.
//

import SwiftUI
import AppIcon

/// Button component
struct StyledButton: View {

    /// Color of the text and tint
    private let foregroundColor: Color = .appDarkGray

    /// Button title text
    var title: LocalizedStringKey

    /// SF Symbol name
    var systemName: SystemImage

    /// Width of the text
    var maxWidth: CGFloat? = .infinity

    /// Closure called when the button is tapped
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: .medium) {
                Image(systemName)
                    .systemImage(size: .icon, weight: .bold)
                    .accessibilityHidden(true)

                Text(title)
                    .textStyle(.button)
                    .foregroundStyle(foregroundColor)
            }
            .frame(maxWidth: maxWidth)
            .padding(.vertical, .medium)
            .padding(.horizontal, .large)
            .tint(foregroundColor)
            .background(LinearGradient(
                colors: [
                    Color.appMaize,
                    Color.appYellow,
                    Color.appMaize
                ],
                startPoint: .leading,
                endPoint: .trailing
            ))
            .clipShape(Capsule())
        }
    }
}

// MARK: - Preview

#Preview {
    StyledButton(
        title: "continue_button",
        systemName: .plus,
        maxWidth: nil,
        onTap: {}
    )
}
