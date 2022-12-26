//
//  SavedWord.swift
//  Define
//
//  Created by Ben Shutt on 26/12/2022.
//

import Foundation

/// A saved word
struct SavedWord: Codable, Identifiable {

    /// `Word`
    var word: Word

    /// `Date`
    var savedDate = Date()

    /// Identifier
    var id: String {
        word.id
    }
}
