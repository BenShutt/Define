//
//  WordListItemView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Word`
struct WordListItemView: View {

    /// `Word`
    var word: Word

    /// Draw `View`
    var body: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: 0) {
                Text(word.title)
                    .h2()

                if let origin = word.origin {
                    Spacer()
                        .frame(height: .small)

                    Text(origin)
                        .body()
                }
            }
            .listItem()

            ChevronView()
        }
        .padding(.large)
    }
}

// MARK: - PreviewProvider

struct WordListItemView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            WordListItemView(word: .preview)
        }
    }
}
