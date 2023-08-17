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
    var foregroundColor: Color = .appDarkGray

    /// Content mode
    var contentMode: ContentMode = .fit

    /// Size of the icon
    var size: CGFloat?

    /// Make icon `View`
    private var iconView: some View {
        image
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .foregroundColor(foregroundColor)
    }

    var body: some View {
        if let size {
            iconView
                .frame(size: size)
        } else {
            iconView
        }
    }
}
