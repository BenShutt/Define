//
//  InputTextField.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `View` to input text
struct InputTextField: View {

    /// Is the field currently focused
    @FocusState private var isFocused: Bool

    /// Text input
    @Binding var text: String

    /// Placeholder text
    var prompt: String

    /// Content of the input
    var contentType: UITextContentType?

    /// Tint color
    private var tintColor: Color {
        .appBlue
    }

    /// Border color
    private var borderColor: Color {
        isFocused ? tintColor : .appLightGray
    }

    /// `View` built from `TextField`
    var body: some View {
        TextField(prompt, text: $text)
            .focused($isFocused)
            .textContentType(contentType)
            .textStyle(.body)
            .tint(tintColor)
            .accentColor(tintColor) // For cursor
            .padding(.mediumLarge)
            .roundedBorder(color: borderColor)
    }
}

// MARK: - PreviewProvider

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(
            text: .constant("The value"),
            prompt: "Enter value...",
            contentType: .name
        )
    }
}
