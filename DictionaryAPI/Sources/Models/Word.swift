//
//  Word.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

public struct Word: JSONModel, Identifiable {

    public var word: String
    public var phonetic: String?
    public var phonetics: [Phonetic]?
    public var origin: String?
    public var meanings: [Meaning]
    public var license: License?
    // sourceUrls: [URL]?

    public var id: String {
        word // TODO: Duplicate words?
    }
}

// MARK: - Word.Phonetic

public extension Word {

    struct Phonetic: JSONModel {

        public var text: String?
        // audio: URL?
        // sourceUrl: URL?
        public var license: License?
    }
}

// MARK: - Word.Meaning

public extension Word {

    struct Meaning: JSONModel {

        public var partOfSpeech: String
        public var definitions: [Definition]
        public var synonyms: [String]?
        public var antonyms: [String]?
    }
}

// MARK: - Word.Meaning.Definition

public extension Word.Meaning {

    struct Definition: JSONModel {

        public var definition: String
        public var example: String?
        public var synonyms: [String]?
        public var antonyms: [String]?
    }
}

// MARK: - Word + Extensions

extension Word: Comparable {

    public static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.word < rhs.word
    }
}

// MARK: - Word + Extensions

public extension Word {

    /// Capitalized word
    var title: String {
        word.capitalized
    }

    /// Definitions
    var definitions: [String] {
        meanings.flatMap { $0.definitions }.map { $0.definition }
    }
}
