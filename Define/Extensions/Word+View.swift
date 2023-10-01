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

    /// Localized subtitle
    /// - Note:`LocalizedStringResource` instead of `LocalizedStringKey`
    /// for use of `String(localized:)`
    var subtitle: LocalizedStringResource? {
        guard let definition = definitions.first else { return nil }
        if definitions.count > 1 {
            return "word_subtitle_more \(definition) \(definitions.count - 1)"
        } else {
            return "word_subtitle \(definition)"
        }
    }

    /// Definitions
    var definitions: [String] {
        meanings
            .flatMap { $0.definitions }
            .map { $0.title }
            .compactMap { $0.trimmed.nilIfEmpty } // TODO: Decode property wrapper?
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
        example?.trimmed.localizedCapitalized.nilIfEmpty // TODO: Decode property wrapper?
    }
}