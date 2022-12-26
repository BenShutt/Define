//
//  WordsViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// View model of the words database
final class WordsViewModel: ObservableObject {

    /// `SavedWord` models to persist
    @AppStorage("words") var words: [SavedWord] = []

    /// Contains `word`
    /// - Parameter word: `Word`
    /// - Returns: `Bool`
    func contains(_ word: Word) -> Bool {
        words.contains { $0.word.id == word.id }
    }
}
