//
//  StickyHeader.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// `View` with sticky header content
struct StickyHeader: ViewModifier {

    /// Text for the title label
    var title: LocalizedStringKey

    /// Optional text for the subtitle label
    var subtitle: LocalizedStringKey?

    /// Amount of padding
    var padding: EdgeInsets

    func body(content: Content) -> some View {
        content.modifier(
            StickyTop {
                TextHeaderView(
                    title: title,
                    subtitle: subtitle,
                    padding: padding
                )
            }
        )
    }
}

// MARK: - View + StickyButton

extension View {

    func stickyHeader(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        padding: EdgeInsets = EdgeInsets.header
    ) -> some View {
        modifier(StickyHeader(
            title: title,
            subtitle: subtitle,
            padding: padding
        ))
    }
}

// MARK: - Preview

#Preview {
    Text("Preview")
        .screen()
        .stickyHeader(
            title: "Preview Title",
            subtitle: "Preview subtitle"
        )
}
