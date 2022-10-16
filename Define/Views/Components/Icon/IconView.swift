//
//  IconView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Icon with a fixed color
struct IconView: View {

    /// Image icon
    var image: Image

    /// Color to tint the image
    var foregroundColor: Color

    /// Content mode
    var contentMode: ContentMode = .fit

    /// Size of the icon
    var size: CGFloat?

    /// Get non-nullable `size` falling back on `-1`
    private var iconSize: CGFloat {
        size ?? -1
    }

    /// Draw `View`
    var body: some View {
        image
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .foregroundColor(foregroundColor)
            .if(iconSize > 0) {
                $0.frame(width: iconSize, height: iconSize)
            }
    }
}
