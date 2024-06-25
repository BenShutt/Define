//
//  ReferenceLibraryCard.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

struct ReferenceLibraryCard: View {
    var term: String

    private var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: .cornerRadius)
    }

    var body: some View {
        HStack(spacing: .large) {
            Image(systemName: "text.book.closed.fill")
                .systemImage(size: 40, weight: .bold)

            VStack(spacing: .small) {
                Text(verbatim: term)
                    .textStyle(
                        .h3,
                        textColor: .appWhite,
                        fill: .leading
                    )

                Text("reference_found")
                    .textStyle(
                        .body,
                        textColor: .appWhite.opacity(0.8),
                        fill: .leading
                    )
            }

            Image(systemName: "chevron.right")
                .systemImage(size: StyledButton.iconSize, weight: .bold)
                .foregroundStyle(Color.appWhite)
        }
        .padding(EdgeInsets.largeMargins)
        .background(LinearGradient.reference)
        .clipShape(shape)
        .overlay {
            shape
                .strokeBorder(Color.appBlack, lineWidth: .borderWidth)
        }
        .compositingGroup()
        .shadow(.container)
    }
}

// MARK: - Preview

#Preview {
    ReferenceLibraryCard(term: "Preview")
}
