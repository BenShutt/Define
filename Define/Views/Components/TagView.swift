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
    var title: String

    /// Color of the foreground
    var foregroundColor: Color

    /// Color of the background
    var backgroundColor: Color

    var body: some View {
        Text(title)
            .foregroundStyle(foregroundColor) // Override
            .textStyle(.tag, lineLimit: 1)
            .padding(.horizontal, .medium)
            .padding(.vertical, .smallMedium)
            .background(GradientBlurView(color: backgroundColor))
            .capsuleBorder(
                color: backgroundColor.opacity(0.2),
                borderWidth: .borderWidth
            )
            .fixedSize(horizontal: true, vertical: true)
    }
}
