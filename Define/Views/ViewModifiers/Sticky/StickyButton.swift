//
//  StickyButton.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI
import AppIcon

/// `View` with sticky button content
struct StickyButton: ViewModifier {

    /// Button title text
    var title: LocalizedStringKey

    /// SF Symbol name
    var systemName: SystemImage

    /// On button tapped
    var onTap: () -> Void

    func body(content: Content) -> some View {
        content.stickyBottom {
            StyledButton(
                title: title,
                systemName: systemName,
                onTap: onTap
            )
            .padding(.margins)
        }
    }
}

// MARK: - View + StickyButton

extension View {
    func stickyButton(
        title: LocalizedStringKey,
        systemName: SystemImage,
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
    Text(verbatim: "Preview")
        .screen()
        .stickyButton(
            title: "continue_button",
            systemName: .plus,
            onTap: {}
        )
}
