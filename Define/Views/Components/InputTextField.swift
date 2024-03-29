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
    var prompt: LocalizedStringKey

    /// Leading image icon
    var image: Image

    /// Content of the input
    var contentType: UITextContentType?

    /// On focus changed observer
    var onFocusChanged: ((Bool) -> Void)?

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
                .textStyle(.body)
                .lineLimit(1)
                .tint(tintColor)
                .accentColor(tintColor) // For cursor
                .foregroundColor(tintColor)
                .padding(.vertical, .mediumLarge)
                .frame(maxHeight: .infinity)

            if !text.isEmpty {
                CrossIconView {
                    text = ""
                }
            }
        }
        .background(Color.appWhite)
        .capsuleBorder(color: borderColor)
        .fixedSize(horizontal: false, vertical: true)
        .keyboardToolbar {
            isFocused = false
        }
        .onTapGesture {
            isFocused = true
        }
        .onChange(of: isFocused) { newValue in
            onFocusChanged?(newValue)
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        InputTextField(
            text: .constant("The value"),
            prompt: "Enter value...",
            image: Image(systemName: "magnifyingglass"),
            contentType: .name
        )
        Spacer()
    }
    .padding(.margins)
}
