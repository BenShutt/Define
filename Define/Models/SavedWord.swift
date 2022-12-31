//
//  SavedWord.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 26/12/2022.
//

import Foundation
import DictionaryAPI

/// A saved word
struct SavedWord: JSONModel, Identifiable {

    /// `UUID`
    var id = UUID()

    /// The word that was saved
    var word: Word

    /// `Date`
    var savedDate = Date()
}
