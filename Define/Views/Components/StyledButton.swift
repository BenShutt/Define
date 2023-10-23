//
//  StyledButton.swift
//  Define
//
//  Created by Ben Shutt on 01/10/2022.
//

import SwiftUI

/// Button component
struct StyledButton: View {

    /// Size of the SF Symbol
    static let iconSize: CGFloat = 20

    /// Color of the text and tint
    private let foregroundColor: Color = .appDarkGray

    /// Button title text
    var title: LocalizedStringKey

    /// SF Symbol name
    var systemName: String

    /// Closure called when the button is tapped
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: .medium) {
                Image(systemName: systemName)
                    .renderingMode(.template)
                    .font(.system(size: Self.iconSize, weight: .bold))

                Text(title)
                    .textStyle(.button)
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.buttonPadding)
            .tint(foregroundColor)
            .background(LinearGradient.button)
            .clipShape(Capsule())
            .compositingGroup()
            .shadow(.container)
        }
    }
}

// MARK: - Preview

#Preview {
    StyledButton(
        title: "PREVIEW BUTTON",
        systemName: "plus",
        onTap: {}
    )
}
