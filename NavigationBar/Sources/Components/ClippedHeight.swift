//
//  ClippedHeight.swift
//  NavigationBar
//
//  Created by Ben Shutt on 26/11/2023.
//

import SwiftUI

/// Clips a view (with a fixed vertical size) by the height scale factor
struct ClippedHeight: ViewModifier {

    /// The maximum height of the content
    @State private var maxHeight: CGFloat = 0

    /// Alignment of the content when added a an overlay
    var alignment: Alignment = .top

    /// Map the maximum height to the clipped height (scaling)
    var scaledHeight: (CGFloat) -> CGFloat

    func body(content: Content) -> some View {
        Color.clear
            .overlay(alignment: alignment) {
                content
                    .fixedSize(horizontal: false, vertical: true)
                    .onSizeChanged { size in
                        if size.height < 500 { // TODO!
                            maxHeight = max(maxHeight, size.height)
                        }
                    }
            }
            .frame(height: scaledHeight(maxHeight))
            .clipped()
    }
}
