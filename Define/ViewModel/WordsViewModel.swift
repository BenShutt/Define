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
final class WordsViewModel: ObservableObject {

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

    /// Contains `word`
    /// - Parameter word: `Word`
    /// - Returns: `Bool`
    func contains(_ word: Word) -> Bool {
        words.contains { $0.word.id == word.id }
    }

    /// Save the given `word`
    /// - Parameter word: `Word`
    func saveWord(_ word: Word) {
        words.append(SavedWord(word: word))
        ReminderNotification.scheduleRequest(word: word)
    }

    /// Delete the given `word`
    /// - Parameter word: `Word`
    func deleteWord(_ word: Word) {
        ReminderNotification.removePendingRequest(word: word)
        words.removeAll { $0.word.id == word.id }
    }
}
