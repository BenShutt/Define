//
//  WordsViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI
import DictionaryAPI

/// View model of the words database
final class WordsViewModel: ObservableObject {

    /// `SavedWord` models to persist
    @AppStorage(UserDefaultKey.words.rawValue) var words: [SavedWord] = []

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
    }

    /// Delete the given `word`
    /// - Parameter word: `Word`
    @discardableResult
    func deleteWord(_ word: Word) -> Bool {
        guard contains(word) else { return false }
        words.removeAll { $0.word.id == word.id }
        return true
    }
}
