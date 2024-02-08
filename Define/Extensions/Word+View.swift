//
//  Word+View.swift
//  Define
//
//  Created by Ben Shutt on 28/09/2023.
//

import Foundation
import SwiftUI
import DictionaryAPI

extension Word {

    /// Capitalized word
    var title: String {
        word.localizedCapitalized
    }

    // TODO: Plural variation seemed not to work here in the assets
    /// Localized subtitle
    var subtitle: LocalizedStringKey? {
        guard let definition = definitions.first else { return nil }
        if definitions.count == 1 {
            return "word_subtitle_one \(definition)"
        } else {
            return "word_subtitle \(definition) \(definitions.count)"
        }
    }

    /// Localized notification title
    var notificationTitle: Localization {
        "reminder_push_title \(title)"
    }

    /// Localized notification subtitle
    var notificationSubtitle: Localization? {
        guard let definition = definitions.first else { return nil }
        if definitions.count > 1 {
            let d = Int8(definitions.count - 1) // TODO: Fix
            return "reminder_push_subtitle \(definition) \(d)"
        } else {
            return "word_subtitle_one \(definition)"
        }
    }

    /// Definitions
    var definitions: [String] {
        meanings
            .flatMap { $0.definitions }
            .map { $0.title }
    }

    /// Parts of speech
    var partsOfSpeech: [String] {
        Set(meanings.map { $0.category }).sorted()
    }
}

// MARK: - Word.Meaning + Extensions

extension Word.Meaning {

    /// Category (or type) of word
    var category: String {
        partOfSpeech.localizedCapitalized
    }
}

// MARK: - Word.Meaning.Definition + Extensions

extension Word.Meaning.Definition {

    /// Capitalized definition
    var title: String {
        definition.localizedCapitalized
    }

    /// Title of example
    var exampleTitle: String? {
        example?.localizedCapitalized
    }
}
