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

    /// Button image shown before the title
    var image: Image?

    /// Closure called when the button is tapped
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: .medium) {
                if let image {
                    image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(size: .iconSmall)
                }

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
        StyledButton(title: "TAP ME!", onTap: {})
    }
}
