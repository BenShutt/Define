//
//  ButtonView.swift
//  Define
//
//  Created by Ben Shutt on 01/10/2022.
//

import SwiftUI

/// Button component
struct ButtonView: View {

    /// Button title text
    var text: String

    /// Button image
    var image: Image?

    /// On tap closure
    var onTap: () -> Void

    /// Draw `View`
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: .medium) {
                if let image {
                    image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(20)
                }

                Text(text)
                    .textStyle(.button)
                    .foregroundColor(Color.appWhite)
            }
            .frame(maxWidth: .infinity)
            .padding(.buttonPadding)
            .tint(.appWhite)
            .background(Color.appPrimary)
        }
        .clipShape(Capsule())
    }
}

// MARK: - PreviewProvider

struct ButtonView_Previews: PreviewProvider {

    static var previews: some View {
        ButtonView(text: "TAP ME!", onTap: {})
    }
}
