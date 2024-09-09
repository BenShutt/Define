//
//  InputTextField.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI
import AppIcon

/// `View` to input text
struct InputTextField: View {

    /// Text input
    @Binding var text: String

    /// Is the field currently focused
    @FocusState.Binding var isFocused: Bool

    /// Placeholder text
    var prompt: LocalizedStringKey

    /// Content of the input
    var contentType: UITextContentType?

    /// Tint color
    private var tintColor: Color {
        .appDarkGray
    }

    /// Border color
    private var borderColor: Color {
        isFocused ? tintColor : .clear
    }

    /// `View` built from `TextField`
    var body: some View {
        HStack(spacing: 0) {
            SearchIconView()

            TextField(prompt, text: $text)
                .focused($isFocused)
                .textContentType(contentType)
                .foregroundStyle(tintColor) // Override
                .textStyle(.body, lineLimit: 1, fill: .leading)
                .tint(tintColor)
                .accentColor(tintColor) // For cursor
                .padding(.vertical, .mediumLarge)

            if !text.isEmpty {
                CrossIconView { text = "" }
            }
        }
        .background(Color.appWhite)
        .capsuleBorder(color: borderColor)
        .keyboardToolbar {
            isFocused = false
        }
        .onTapGesture {
            isFocused = true
        }
        .accessibilityAddTraits(.isButton)
    }
}
