//
//  SavedWord.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 26/12/2022.
//

import Foundation

/// A saved word
public struct SavedWord: JSONModel, Identifiable {

    /// `Word`
    public var word: Word

    /// `Date`
    public var savedDate: Date

    /// Public memberwise initializer
    /// - Parameters:
    ///   - word: `Word`
    ///   - savedDate: `Date` defaults to now
    public init(word: Word, savedDate: Date = Date()) {
        self.word = word
        self.savedDate = savedDate
    }

    /// Identifier
    public var id: String {
        word.id
    }
}
