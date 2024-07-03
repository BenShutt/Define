//
//  SavedWord.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 26/12/2022.
//

import Foundation
import SwiftData
import DictionaryAPI

// MARK: - SavedWord

@Model
class SavedWord: Equatable, Hashable {
    @Attribute(.unique) var word: String
    @Relationship(deleteRule: .cascade) var meanings: [Meaning]
    var createdDate: Date

    init(
        word: String,
        meanings: [Meaning],
        createdDate: Date = .now
    ) {
        self.word = word
        self.meanings = meanings
        self.createdDate = createdDate
    }
}

// MARK: - Meaning

@Model
class Meaning: Equatable, Hashable {
    var partOfSpeech: String
    @Relationship(deleteRule: .cascade) var definitions: [Definition]

    init(
        partOfSpeech: String,
        definitions: [Definition]
    ) {
        self.partOfSpeech = partOfSpeech
        self.definitions = definitions
    }
}

// MARK: - Definition

@Model
class Definition: Equatable, Hashable {
    var definition: String
    var example: String?

    init(
        definition: String,
        example: String?
    ) {
        self.definition = definition
        self.example = example
    }
}

// MARK: - SavedWord + Word

extension SavedWord {
    var model: Word {
        .init(
            word: word,
            meanings: meanings.map { meaning in
                .init(
                    partOfSpeech: meaning.partOfSpeech,
                    definitions: meaning.definitions.map { definition in
                        .init(
                            definition: definition.definition,
                            example: definition.example
                        )
                    }
                )
            }
        )
    }
}

// MARK: - Word + SavedWord

extension Word {
    func savedWord(createdDate: Date = .now) -> SavedWord {
        .init(
            word: word,
            meanings: meanings.map { meaning in
                .init(
                    partOfSpeech: meaning.partOfSpeech,
                    definitions: meaning.definitions.map { definition in
                        .init(
                            definition: definition.definition,
                            example: definition.example
                        )
                    }
                )
            },
            createdDate: createdDate
        )
    }
}
