//
//  Word.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

public struct Word: JSONModel, Validated {

    public var word: String
    public var phonetic: String?
    public var phonetics: [Phonetic]?
    public var origin: String?
    public var meanings: [Meaning]
    public var license: License?

    public mutating func validate() throws {
        try word.validate()
        try phonetic?.validate()
        try phonetics?.validate()
        try origin?.validate()
        try meanings.validate()
        try license?.validate()
    }
}

// MARK: - Word.Phonetic

public extension Word {

    struct Phonetic: JSONModel, Validated {

        public var text: String?
        public var license: License?

        public mutating func validate() throws {
            try text?.validate()
            try license?.validate()
        }
    }
}

// MARK: - Word.Meaning

public extension Word {

    struct Meaning: JSONModel, Validated {

        public var partOfSpeech: String
        public var definitions: [Definition]
        public var synonyms: [String]?
        public var antonyms: [String]?

        public mutating func validate() throws {
            try partOfSpeech.validate()
            try definitions.validate()
            try synonyms?.validate()
            try antonyms?.validate()
        }
    }
}

// MARK: - Word.Meaning.Definition

public extension Word.Meaning {

    struct Definition: JSONModel, Validated {

        public var definition: String
        public var example: String?
        public var synonyms: [String]?
        public var antonyms: [String]?

        public mutating func validate() throws {
            try definition.validate()
            try example?.validate()
            try synonyms?.validate()
            try antonyms?.validate()
        }
    }
}

// MARK: - Word + Identifiable

extension Word: Identifiable {

    /// Words do not have ID properties, so we use the word itself.
    /// - Warning It does mean that if the same search returns multiple words from the API only one can be saved
    public var id: String {
        word.lowercased()
    }
}

// MARK: - Word + Comparable

extension Word: Comparable {

    public static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.word < rhs.word
    }
}

// MARK: - Word + Extensions

public extension Word {

    init(word: String) {
        self.init(word: word, meanings: [])
    }
}
