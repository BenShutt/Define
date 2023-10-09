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
                Text(verbatim: .SearchHeaderView.title)
                    .h1()

                Text(.init(.SearchHeaderView.subtitle))
                    .body()
                    .padding(.top, .medium)
                    .padding(.bottom, .extraLarge)
            }

            InputTextField(
                text: $searchText,
                prompt: .SearchHeaderView.prompt,
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

// MARK: - PreviewProvider

struct SearchHeaderView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            SearchHeaderView(searchText: .constant("Some search"))
            Spacer()
        }
    }
}
