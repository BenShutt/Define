//
//  SearchHeaderView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

/// Header UI for searching
struct SearchHeaderView: View {

    /// Text being searched
    @Binding var searchText: String

    /// Is the field currently focused so the content is compressed
    ///
    /// - Note:
    /// There are two states here to handle both the @FocusState and the animation.
    /// The @FocusState is on the InputTextField and this is the animation property.
    /// The two should always be equivalent in value
    @State private var isTextInputFocused = false

    /// Update the top padding of the header
    private var padding: EdgeInsets {
        var padding: EdgeInsets = .header
        padding.top = .medium
        return padding
    }

    var body: some View {
        HeaderView(spacing: 0, padding: padding) {
            if !isTextInputFocused {
                Text("search_header_title")
                    .textStyle(.h1, fill: .leading)

                Text("search_header_subtitle")
                    .textStyle(.body, fill: .leading)
                    .padding(.top, .medium)
                    .padding(.bottom, .extraLarge)
            }

            InputTextField(
                text: $searchText,
                prompt: "search_header_prompt",
                image: Image(systemName: "magnifyingglass"),
                onFocusChanged: { isFocused in
                    withAnimation(.linear(duration: 0.1)) {
                        isTextInputFocused = isFocused
                    }
                }
            )
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 0) {
        SearchHeaderView(searchText: .constant(""))
        Spacer()
    }
}
