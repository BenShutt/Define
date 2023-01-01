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
    var foregroundColor: Color = .appDarkGray

    /// `Color` of the background
    var backgroundColor: Color = .appLightGray

    /// Draw `View`
    var body: some View {
        Text(text)
            .textStyle(.tag)
            .foregroundColor(foregroundColor)
            .padding(.smallMedium)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

// MARK: - PreviewProvider

struct TagView_Previews: PreviewProvider {

    static var previews: some View {
        TagView(text: "Adjective")
    }
}
