//
//  Word.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

public struct Word: JSONModel {
    public var word: String
    public var meanings: [Meaning]

    public init(
        word: String,
        meanings: [Meaning]
    ) {
        self.word = word
        self.meanings = meanings
    }
}

// MARK: - Word.Meaning

public extension Word {
    struct Meaning: JSONModel {
        public var partOfSpeech: String
        public var definitions: [Definition]

        public init(
            partOfSpeech: String,
            definitions: [Definition]
        ) {
            self.partOfSpeech = partOfSpeech
            self.definitions = definitions
        }
    }
}

// MARK: - Word.Meaning.Definition

public extension Word.Meaning {
    struct Definition: JSONModel {
        public var definition: String
        public var example: String?

        public init(
            definition: String,
            example: String?
        ) {
            self.definition = definition
            self.example = example
        }
    }
}

// MARK: - Word + Validated

extension Word: Validated {
    public mutating func validate() throws {
        try word.validate()
        try meanings.validate()

        // All words are regarded in lowercase due to the missing ID
        word = word.lowercased()
    }
}

// MARK: - Word.Meaning + Validated

extension Word.Meaning: Validated {
    public mutating func validate() throws {
        try partOfSpeech.validate()
        try definitions.validate()
    }
}

// MARK: - Word.Meaning.Definition + Validated

extension Word.Meaning.Definition: Validated {
    public mutating func validate() throws {
        try definition.validate()
        try example?.validate()
    }
}
