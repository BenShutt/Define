//
//  Icon.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Icon with a fixed olor
struct Icon: View {

    /// Image icon
    var image: Image

    /// Color to tint the image
    var foregroundColor: Color

    /// Content mode
    var contentMode: ContentMode = .fit

    /// Draw `View`
    var body: some View {
        image
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .foregroundColor(foregroundColor)
            .frame(width: .iconSize, height: .iconSize)
    }
}
