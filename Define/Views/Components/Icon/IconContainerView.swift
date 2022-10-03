//
//  IconContainerView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Container of an icon view
struct IconContainerView<Body: View>: View {

    /// Make content view
    @ViewBuilder
    var contentView: Body

    /// Draw `View`
    var body: some View {
        ZStack {
            contentView
        }
        .frame(width: .iconContainerWidth)
    }
}
