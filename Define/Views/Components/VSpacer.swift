//
//  VSpacer.swift
//  Define
//
//  Created by Ben Shutt on 01/01/2023.
//

import SwiftUI

/// Spacer for in a vertical layout
struct VSpacer: View {

    /// Height of frame
    var height: CGFloat

    /// Draw a `Spacer` with a fixed height
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}
