//
//  WordCategoryView.swift
//  Define
//
//  Created by Ben Shutt on 29/01/2023.
//

import SwiftUI
import DictionaryAPI

/// Capsule for a part of speech (category)
struct WordCategoryView: View {

    /// Part of speech
    var category: String

    /// Map `category` to `WordCategory`
    var wordCategory: WordCategory? {
        WordCategory(rawValue: category.lowercased())
    }

    /// Background color
    var backgroundColor: Color {
        .appLightGray
    }

    /// Draw view
    var body: some View {
        TagView(
            text: category,
            foregroundColor: .appDarkGray,
            backgroundColor: backgroundColor
        )
    }
}

// MARK: - PreviewProvider

struct WordCategoryView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            ForEach(WordCategory.allCases) {
                WordCategoryView(category: $0.rawValue)
            }
        }
    }
}
