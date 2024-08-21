//
//  TagView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import FlowLayout

/// Tag capsule
struct TagView: View, FlowLayoutSized {
    private let padding = EdgeInsets(vertical: .smallMedium, horizontal: .medium)
    private let textStyle: TextStyle = .tag

    /// Title of the tag
    var title: String

    /// Color of the foreground
    var foregroundColor: Color

    /// Color of the background
    var backgroundColor: Color

    var body: some View {
        Text(title)
            .foregroundStyle(foregroundColor) // Override
            .textStyle(textStyle, lineLimit: 1)
            .padding(padding)
            .background(GradientBlurView(color: backgroundColor))
            .capsuleBorder(
                color: backgroundColor.opacity(0.2),
                borderWidth: .borderWidth
            )
            .fixedSize(horizontal: true, vertical: true)
    }

    // MARK: - FlowLayoutSized

    func size(in boundsSize: CGSize) -> CGSize {
        (title as NSString).size(withAttributes: [
            .font: textStyle.uiFont as UIFont
        ])
        .padding(padding)
    }
}

// MARK: - CGSize + Extensions

private extension CGSize {
    func padding(_ insets: EdgeInsets) -> CGSize {
        CGSize(
            width: width + insets.horizontal,
            height: height + insets.vertical
        )
    }
}
