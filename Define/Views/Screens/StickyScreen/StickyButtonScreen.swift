//
//  StickyButtonScreen.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

/// `Screen` with sticky button content
struct StickyButtonScreen<Content: View>: View {

    /// Button title text
    var buttonText: String

    /// On button tapped
    var onButtonTap: () -> Void

    /// Make `Content` view
    @ViewBuilder var content: () -> Content

    /// Draw `View`
    var body: some View {
        StickyBottomScreen(content: content) {
            ButtonView(text: buttonText, onTap: onButtonTap)
                .padding(.largeMargins)
        }
    }
}

// MARK: - PreviewProvider

struct StickyButtonScreen_Previews: PreviewProvider {

    static var previews: some View {
        StickyButtonScreen(
            buttonText: "TAP ME!",
            onButtonTap: {},
            content: {
                ZStack {
                    Color.appLightGray
                        .ignoresSafeArea()
                    Text("Test")
                        .h1()
                }
            }
        )
    }
}
