//
//  Word.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

public struct Word: JSONModel {
    @Trimmed @Lowercased public var word: String
    public var meanings: [Meaning]

    public init(
        word: String,
        meanings: [Meaning]
    ) {
        _word = .init(wrappedValue: .init(wrappedValue: word))
        self.meanings = meanings
    }
}

// MARK: - Word.Meaning

public extension Word {
    struct Meaning: JSONModel {
        @Trimmed public var partOfSpeech: String
        public var definitions: [Definition]

        public init(
            partOfSpeech: String,
            definitions: [Definition]
        ) {
            _partOfSpeech = .init(wrappedValue: partOfSpeech)
            self.definitions = definitions
        }
    }
}

// MARK: - Word.Meaning.Definition

public extension Word.Meaning {
    struct Definition: JSONModel {
        @Trimmed public var definition: String
        @Trimmed public var example: String?

        public init(
            definition: String,
            example: String?
        ) {
            _definition = .init(wrappedValue: definition)
            _example = .init(wrappedValue: example)
        }
    }
}
