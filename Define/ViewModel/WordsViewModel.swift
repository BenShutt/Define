//
//  WordsViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI
import DictionaryAPI

/// View model of the words database
///
/// - Note:
/// The `Word` does not have an "id" field so we have to check equality via the word itself.
/// This is a little inconvenient as a word can have multiple entities in the dictionary db.
@MainActor final class WordsViewModel: ObservableObject {

    /// `SavedWord` models to persist
    @AppStorage(UserDefaultKey.words.rawValue) private var savedWords: [SavedWord] = []

    /// Get and set `savedWords`
    private(set) var words: [SavedWord] {
        get {
            savedWords.sorted(by: >)
        }
        set {
            savedWords = newValue
        }
    }

    /// Shorthand for `isEmpty` of `words`
    var isEmpty: Bool {
        words.isEmpty
    }

    // TODO: Clean up Word IDs (different to SavedWord IDs)
    func word(for id: SavedWordID) -> SavedWord? {
        words.first { $0.id == id }
    }

    /// Contains `word`
    /// - Parameter word: `Word`
    /// - Returns: `Bool`
    func contains(_ word: Word) -> Bool {
        words.contains { $0.word == word }
    }

    /// Add the saved word
    /// - Parameter savedWord: Saved word to add
    func addWord(_ savedWord: SavedWord) {
        words.append(savedWord)
    }

    /// Remove the saved word
    /// - Parameter savedWord: Saved word to remove
    func removeWord(_ savedWord: SavedWord) {
        words.removeAll { $0.id == savedWord.id }
    }
}
