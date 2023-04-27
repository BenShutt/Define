//
//  StickyButton.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

/// `View` with sticky button content
struct StickyButton: ViewModifier {

    /// Button title text
    var title: String

    /// Button image
    var image: Image?

    /// On button tapped
    var onTap: () -> Void

    func body(content: Content) -> some View {
        content.modifier(
            StickyBottom {
                ButtonView(
                    title: title,
                    image: image,
                    onTap: onTap
                )
                .padding(.largeMargins)
            }
        )
    }
}

// MARK: - PreviewProvider

struct StickyButton_Previews: PreviewProvider {

    static var previews: some View {
        ScreenBody {
            Text("Test")
        }
        .modifier(StickyButton(
            title: "TAP ME!",
            onTap: {}
        ))
    }
}
