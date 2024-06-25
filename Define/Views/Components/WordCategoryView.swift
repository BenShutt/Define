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
        guard let wordCategory else { return .appLightGray }
        return switch wordCategory {
        case .adjective: .appBlue
        case .adverb: .appPurple
        case .interjection: .appOrange
        case .noun: .appYellow
        case .numeral: .appGreen
        case .pronoun: .appPink
        case .verb: .appRed
        }
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

// MARK: - Preview

#Preview {
    VStack {
        ForEach(WordCategory.allCases) {
            WordCategoryView(category: $0.rawValue)
        }
    }
}
