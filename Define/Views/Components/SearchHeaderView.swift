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
    @Binding var search: String

    /// Is the field currently focused so the content is compressed
    @FocusState.Binding var isFocused: Bool

    /// Animation property that changes with `isFocused`
    /// The two should always be equivalent in value
    @State private var isCollapsed = false

    var body: some View {
        VStack(spacing: 0) {
            if !isCollapsed {
                Text("search_header_title")
                    .textStyle(.h1, fill: .leading)

                Text("search_header_subtitle")
                    .textStyle(.body, fill: .leading)
                    .padding(.top, .medium)
                    .padding(.bottom, .extraLarge)
                    .tint(Color(UIColor.systemBlue)) // Markdown URL
            }

            InputTextField(
                text: $search,
                isFocused: $isFocused,
                prompt: "search_header_prompt"
            )
        }
        .padding(.margins)
        .background {
            NavigationBarBackground()
                .ignoresSafeArea(edges: .top)
        }
        .onChange(of: isFocused) {
            withAnimation(.linear(duration: 0.1)) {
                isCollapsed = isFocused
            }
        }
    }
}

// MARK: - Preview

private struct PreviewView: View {
    @State private var search = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            SearchHeaderView(
                search: $search,
                isFocused: $isFocused
            )
            Spacer()
        }
    }
}

#Preview {
    PreviewView()
}
