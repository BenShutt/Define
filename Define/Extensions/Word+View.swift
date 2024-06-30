//
//  Word+View.swift
//  Define
//
//  Created by Ben Shutt on 28/09/2023.
//

import Foundation
import SwiftUI
import DictionaryAPI

// MARK: - Word + Extensions

extension Word {

    /// Capitalized word
    var title: String {
        word.localizedCapitalized
    }

    /// Localized subtitle
    var subtitle: String? {
        guard let definition = definitions.first else { return nil }
        guard definitions.count > 1 else { return definition }
        return String(localized: "word_subtitle \(definition) \(definitions.count)")
    }

    /// Localized notification title
    var notificationTitle: String {
        String(localized: "reminder_push_title \(title)")
    }

    /// Localized notification subtitle
    var notificationSubtitle: String? {
        subtitle
    }

    /// Definitions
    var definitions: [String] {
        meanings
            .flatMap { $0.definitions }
            .map { $0.title }
    }

    /// Parts of speech
    var partsOfSpeech: [String] {
        Set(meanings.map { $0.partOfSpeechTitle }).sorted()
    }
}

// MARK: - Word.Meaning + Extensions

extension Word.Meaning {

    /// Capitalized part of speech
    var partOfSpeechTitle: String {
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

// MARK: - SavedWord + Extensions

extension SavedWord {

    /// Formatted string of how long ago the word was saved
    var addedSince: LocalizedStringKey {
        let minutes = Calendar.current.dateComponents(
            [.minute],
            from: savedDate,
            to: .now
        ).minute ?? 0

        guard minutes > 0 else { return "added_just_now" }
        let formatter = DateComponentsFormatter.timeInterval
        let formatted = formatter.string(from: savedDate, to: .now) ?? ""
        return "added \(formatted)"
    }
}
