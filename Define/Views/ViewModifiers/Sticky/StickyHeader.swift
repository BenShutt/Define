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
    var title: String

    /// Optional text for the subtitle label
    var subtitle: String?

    /// Gradient color
    var color: Color

    /// Top padding
    var topPadding = EdgeInsets.header.top

    func body(content: Content) -> some View {
        content.modifier(
            StickyTop {
                TextHeaderView(
                    title: title,
                    subtitle: subtitle,
                    color: color,
                    topPadding: topPadding
                )
            }
        )
    }
}

// MARK: - View + StickyButton

extension View {

    func stickyHeader(
        title: String,
        subtitle: String? = nil,
        color: Color,
        topPadding: CGFloat = EdgeInsets.header.top
    ) -> some View {
        modifier(StickyHeader(
            title: title,
            subtitle: subtitle,
            color: color,
            topPadding: topPadding
        ))
    }
}

// MARK: - PreviewProvider

struct StickyHeader_Previews: PreviewProvider {

    static var previews: some View {
        Text(verbatim: "Test")
            .screen()
            .stickyHeader(
                title: "Title text",
                subtitle: "More Subtitle text",
                color: .appBlue
            )
    }
}
