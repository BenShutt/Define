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
    var title: LocalizedStringKey

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
                .padding(.horizontal, .large)
                .padding(.vertical, .vMargin)
            }
        )
    }
}

// MARK: - View + StickyButton

extension View {

    func stickyButton(
        title: LocalizedStringKey,
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

// MARK: - Preview

#Preview {
    Text("Preview")
        .screen()
        .stickyButton(
            title: "PREVIEW BUTTON",
            systemName: "plus",
            onTap: {}
        )
}
