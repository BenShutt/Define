//
//  ReferenceLibraryCard.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

struct ReferenceLibraryCard: View {

    var word: String

    private var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: .cornerRadius)
    }

    var body: some View {
        HStack(spacing: .large) {
            Image(systemName: "text.book.closed.fill")
                .font(.system(size: 40, weight: .bold))

            VStack(alignment: .leading, spacing: .small) {
                Text(verbatim: word)
                    .foregroundStyle(Color.appWhite)
                    .h3()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("reference_found")
                    .foregroundStyle(Color.appWhite.opacity(0.8))
                    .body()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: StyledButton.iconSize, weight: .bold))
        }
        .multilineTextAlignment(.leading)
        .foregroundStyle(Color.appWhite)
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
    ReferenceLibraryCard(word: "Hey")
        .padding(EdgeInsets.margins)
}
