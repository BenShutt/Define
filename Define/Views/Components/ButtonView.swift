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

    /// On tap closure
    var onTap: () -> Void

    /// Draw `View`
    var body: some View {
        Button(action: onTap) {
            Text(text)
                .textStyle(.button)
                .foregroundColor(Color.appWhite)
                .frame(maxWidth: .infinity)
                .padding(.buttonPadding)
        }
        .background(Color.appPrimary)
        .clipShape(Capsule())
    }
}

// MARK: - PreviewProvider

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "TAP ME!", onTap: {})
    }
}
