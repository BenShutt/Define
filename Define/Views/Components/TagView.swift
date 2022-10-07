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

    /// Draw `View`
    var body: some View {
        Text(text)
            .textStyle(.tag)
            .foregroundColor(Color.appBlack)
            .padding(.small)
            .background(Color.appLightOrange)
            .clipShape(Capsule())
    }
}

// MARK: - PreviewProvider

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "Adjective")
    }
}
