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
        guard let wordCategory else { return .appLightGray}
        switch wordCategory {
        case .adjective: return .appBlue
        case .adverb: return .appPurple
        case .interjection: return .appOrange
        case .noun: return .appYellow
        case .numeral: return .appGreen
        case .pronoun: return .appPink
        case .verb: return .appRed
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
