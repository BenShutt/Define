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

    /// SF Symbol name
    var systemName: String

    /// On button tapped
    var onTap: () -> Void

    func body(content: Content) -> some View {
        content.modifier(
            StickyBottom {
                StyledButton(
                    title: title,
                    systemName: systemName,
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
        systemName: String,
        onTap: @escaping () -> Void
    ) -> some View {
        modifier(StickyButton(
            title: title,
            systemName: systemName,
            onTap: onTap
        ))
    }
}

// MARK: - PreviewProvider

struct StickyButton_Previews: PreviewProvider {

    static var previews: some View {
        Text(verbatim: "Test")
            .screen()
            .stickyButton(
                title: "TAP ME!",
                systemName: "plus",
                onTap: {}
            )
    }
}
