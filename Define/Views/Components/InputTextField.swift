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

    /// Leading image icon
    var image: Image

    /// Content of the input
    var contentType: UITextContentType?

    /// Tint color
    private var tintColor: Color {
        .appBlue
    }

    /// Border color
    private var borderColor: Color {
        isFocused ? tintColor : .appFaintGray
    }

    /// `View` built from `TextField`
    var body: some View {
        HStack(spacing: 0) {
            SearchIconView()

            TextField(prompt, text: $text)
                .focused($isFocused)
                .textContentType(contentType)
                .textStyle(.body)
                .tint(tintColor)
                .accentColor(tintColor) // For cursor
                .padding(.mediumLarge)
                .frame(maxHeight: .infinity)

            if !text.isEmpty {
                CrossIconView {
                    text = ""
                }
            }
        }
        .shapeBorder(color: borderColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - PreviewProvider

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputTextField(
                text: .constant("The value"),
                prompt: "Enter value...",
                image: .search,
                contentType: .name
            )
            Spacer()
        }
        .padding(.margins)
    }
}
