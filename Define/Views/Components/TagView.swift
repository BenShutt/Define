//
//  TagView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

/// Tag capsule
struct TagView: View {

    /// `String` text
    var text: String

    /// `Color` of the foreground
    var foregroundColor: Color

    /// `Color` of the background
    var backgroundColor: Color

    /// Draw `View`
    var body: some View {
        Text(verbatim: text)
            .textStyle(.tag)
            .foregroundColor(foregroundColor)
            .padding(.vertical, .smallMedium)
            .padding(.horizontal, .medium)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}
