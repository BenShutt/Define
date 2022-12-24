//
//  Definition.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation

/// Definition of a word
struct Definition: JSONModel, Identifiable {

    /// Word to define
    var word: String

    /// Definitions of the word
    var definitions: [String]

    /// Date the word was saved
    var saveDate: Date

    /// Identifier
    var id: String {
        word // TODO: Duplicate words?
    }
}
