//
//  Word.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

public struct Word: JSONModel, Validated {

    public var word: String
    public var meanings: [Meaning]

    public mutating func validate() throws {
        try word.validate()
        try meanings.validate()
    }
}

// MARK: - Word.Meaning

public extension Word {

    struct Meaning: JSONModel, Validated {

        public var partOfSpeech: String
        public var definitions: [Definition]

        public mutating func validate() throws {
            try partOfSpeech.validate()
            try definitions.validate()
        }
    }
}

// MARK: - Word.Meaning.Definition

public extension Word.Meaning {

    struct Definition: JSONModel, Validated {

        public var definition: String
        public var example: String?

        public mutating func validate() throws {
            try definition.validate()
            try example?.validate()
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
