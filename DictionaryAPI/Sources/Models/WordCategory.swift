//
//  WordCategory.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 29/01/2023.
//

import Foundation

/// A category of word
public enum WordCategory: String, CaseIterable, Identifiable {

    case adjective
    case adverb
    case interjection
    case noun
    case numeral
    case pronoun
    case verb

    public var id: Self { self }
}
