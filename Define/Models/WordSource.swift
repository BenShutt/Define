//
//  WordSource.swift
//  Define
//
//  Created by Ben Shutt on 02/07/2024.
//

import SwiftUI
import SwiftData
import DictionaryAPI

enum WordSource: Equatable, Hashable {
    case api(Word)
    case saved(SavedWord)

    var word: Word {
        switch self {
        case let .api(word): word
        case let .saved(savedWord): savedWord.model
        }
    }

    var savedWord: SavedWord? {
        if case .saved(let savedWord) = self { savedWord } else { nil }
    }

    var isSaved: Bool {
        savedWord != nil
    }

    init(modelContext: ModelContext, word: Word) {
        let wordDb = WordDb(modelContext: modelContext)
        if let savedWord = wordDb.fetchOrNil(word: word.word) {
            // TODO: Update if changed?
            self = .saved(savedWord)
        } else {
            self = .api(word)
        }
    }
}

// MARK: - Word + Extensions

extension Word {

    /// Definitions
    private var definitions: [String] {
        meanings
            .flatMap { $0.definitions }
            .map { $0.title }
    }

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

    /// Map to part of speech
    var category: PartOfSpeech? {
        PartOfSpeech(value: partOfSpeech)
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

    /// Localized notification title
    var notificationTitle: String {
        String(localized: "reminder_push_title \(model.title)")
    }

    /// Localized notification subtitle
    var notificationSubtitle: String? {
        model.subtitle
    }

    /// Formatted string of how long ago the word was saved
    var addedSince: LocalizedStringKey {
        let minutes = Calendar.current.dateComponents(
            [.minute],
            from: createdDate,
            to: .now
        ).minute ?? 0

        guard minutes > 0 else { return "added_just_now" }
        let formatter = DateComponentsFormatter.timeInterval
        let formatted = formatter.string(from: createdDate, to: .now) ?? ""
        return "added \(formatted)"
    }
}
