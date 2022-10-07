//
//  ButtonView.swift
//  Define
//
//  Created by Ben Shutt on 01/10/2022.
//

import SwiftUI

/// Button component
struct ButtonView: View {

    /// Button title text
    var text: String

    /// On click closure
    var onClick: () -> Void

    /// Draw `View`
    var body: some View {
        Button(action: onClick) {
            Text(text)
                .textStyle(.button)
                .foregroundColor(Color.appWhite)
                .frame(maxWidth: .infinity)
                .padding(.margins)
        }
        .background(Color.appPrimary)
        .clipShape(Capsule())
    }
}

// MARK: - PreviewProvider

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "CLICK ME!", onClick: {})
    }
}
