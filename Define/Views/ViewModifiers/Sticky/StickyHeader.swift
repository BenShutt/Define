//
//  StickyHeader.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// `View` with sticky header content
struct StickyHeader: ViewModifier {

    /// Title of the header
    var title: String

    /// Optional subtitle of the header
    var subtitle: String?

    func body(content: Content) -> some View {
        content.modifier(
            StickyTop {
                HeaderView(
                    title: title,
                    subtitle: subtitle
                )
            }
        )
    }
}

// MARK: - View + StickyButton

extension View {

    func stickyHeader(
        title: String,
        subtitle: String? = nil
    ) -> some View {
        modifier(StickyHeader(
            title: title,
            subtitle: subtitle
        ))
    }
}

// MARK: - PreviewProvider

struct StickyHeader_Previews: PreviewProvider {

    static var previews: some View {
        ScreenBody {
            Text("Test")
        }
        .stickyHeader(
            title: "Title text",
            subtitle: "More Subtitle text"
        )
    }
}
