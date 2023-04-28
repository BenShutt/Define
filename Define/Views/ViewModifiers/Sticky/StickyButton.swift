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
                StyledButton(
                    title: title,
                    image: image,
                    onTap: onTap
                )
                .padding(.largeMargins)
            }
        )
    }
}

// MARK: - View + StickyButton

extension View {

    func stickyButton(
        title: String,
        image: Image? = nil,
        onTap: @escaping () -> Void
    ) -> some View {
        modifier(StickyButton(
            title: title,
            image: image,
            onTap: onTap
        ))
    }
}

// MARK: - PreviewProvider

struct StickyButton_Previews: PreviewProvider {

    static var previews: some View {
        ScreenBody {
            Text("Test")
        }
        .stickyButton(
            title: "TAP ME!",
            onTap: {}
        )
    }
}
