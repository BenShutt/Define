//
//  SearchHeaderView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

// TODO: Add hyperlink to "Free Dictionary API"

/// Header UI for searching
struct SearchHeaderView: View {

    /// Text being searched
    @Binding var searchText: String

    /// Is the field currently focused so the content is compressed
    ///
    /// - Note:
    /// There are two states here to handle both the @FocusState and the animation.
    /// The two should always be equivelent in value
    @State private var isTextInputFocused = false

    /// Padding
    var padding: EdgeInsets {
        var padding: EdgeInsets = .largeMargins
        if isTextInputFocused {
            padding.top = .medium
        }
        return padding
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !isTextInputFocused {
                Text(String.SearchHeaderView.title)
                    .h1()

                VSpacer(height: .medium)

                Text(String.SearchHeaderView.subtitle)
                    .body()

                VSpacer(height: .extraLarge)
            }

            InputTextField(
                text: $searchText,
                prompt: .SearchHeaderView.prompt,
                image: .search,
                onFocusChanged: { isFocused in
                    withAnimation(.linear(duration: .accordion)) {
                        isTextInputFocused = isFocused
                    }
                }
            )
        }
        .padding(padding)
        .background(
            GradientBlurView()
                .appShadow()
                .ignoresSafeArea()
        )
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
