//
//  SavedWord.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 26/12/2022.
//

import SwiftUI
import DictionaryAPI

// TODO: Migrate to SwiftData

typealias SavedWordId = UUID

/// A saved word
struct SavedWord: JSONModel, Identifiable, Comparable {

    /// `UUID`
    var id = SavedWordId()

    /// The word that was saved
    var word: Word

    /// `Date`
    var savedDate = Date()

    // MARK: - Comparable

    static func < (lhs: SavedWord, rhs: SavedWord) -> Bool {
        lhs.savedDate < rhs.savedDate
    }
}
