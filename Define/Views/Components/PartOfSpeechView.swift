//
//  PartOfSpeechView.swift
//  Define
//
//  Created by Ben Shutt on 29/01/2023.
//

import SwiftUI
import DictionaryAPI

/// Capsule for a part of speech (category)
struct PartOfSpeechView: View {

    /// Part of speech
    var partOfSpeech: String

    /// Background color of the capsule
    private var backgroundColor: Color {
        PartOfSpeech(value: partOfSpeech)?.backgroundColor ?? .appLightGray
    }

    /// Draw view
    var body: some View {
        TagView(
            text: partOfSpeech,
            foregroundColor: .appDarkGray,
            backgroundColor: backgroundColor
        )
    }
}

// MARK: - PartOfSpeech + Color

extension PartOfSpeech {
    var backgroundColor: Color {
        switch self {
        case .adjective: .appBlue
        case .adverb: .appPurple
        case .interjection: .appOrange
        case .noun: .appYellow
        case .numeral: .appGreen
        case .pronoun: .appPink
        case .verb: .appRed
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        ForEach(PartOfSpeech.allCases) {
            PartOfSpeechView(partOfSpeech: $0.rawValue)
        }
    }
}
