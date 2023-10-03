//
//  StyledButton.swift
//  Define
//
//  Created by Ben Shutt on 01/10/2022.
//

import SwiftUI

/// Button component
struct StyledButton: View {

    /// Color of the text and tint
    private let foregroundColor: Color = .appDarkGray

    /// Button title text
    var title: String

    /// SF Symbol name
    var systemName: String

    /// Closure called when the button is tapped
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: .medium) {
                Image(systemName: systemName)
                    .renderingMode(.template)
                    .font(.system(size: 20, weight: .bold))

                Text(verbatim: title)
                    .textStyle(.button)
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.buttonPadding)
            .tint(foregroundColor)
            .background(RadialGradient.button)
            .clipShape(Capsule())
        }
    }
}

// MARK: - PreviewProvider

struct StyledButton_Previews: PreviewProvider {

    static var previews: some View {
        StyledButton(title: "TAP ME!", systemName: "plus", onTap: {})
    }
}
