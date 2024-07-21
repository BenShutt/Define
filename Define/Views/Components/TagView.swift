//
//  TagView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

/// Tag capsule
struct TagView: View {

    /// Title of the tag
    var text: String

    /// Color of the foreground
    var foregroundColor: Color

    /// Color of the background
    var backgroundColor: Color

    var body: some View {
        Text(verbatim: text)
            .foregroundStyle(foregroundColor) // Override
            .textStyle(.tag)
            .padding(.vertical, .smallMedium)
            .padding(.horizontal, .medium)
            .background(GradientBlurView(color: backgroundColor))
            .capsuleBorder(
                color: backgroundColor.opacity(0.2),
                borderWidth: .borderWidth
            )
    }
}
