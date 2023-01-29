//
//  StickyButton.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

/// `Screen` with sticky button content
struct StickyButton<Content: View>: View {

    /// Button title text
    var buttonText: String

    /// Button image
    var buttonImage: Image?

    /// On button tapped
    var onButtonTap: () -> Void

    /// Make `Content` view
    @ViewBuilder var content: () -> Content

    /// Draw `View`
    var body: some View {
        StickyBottom(content: content) {
            ButtonView(
                text: buttonText,
                image: buttonImage,
                onTap: onButtonTap
            )
            .padding(.largeMargins)
        }
    }
}

// MARK: - PreviewProvider

struct StickyButton_Previews: PreviewProvider {

    static var previews: some View {
        StickyButton(
            buttonText: "TAP ME!",
            onButtonTap: {},
            content: {
                ScreenBody(backgroundColor: .appBlue.opacity(0.2)) {
                    Text("Test")
                        .h1()
                }
            }
        )
    }
}
