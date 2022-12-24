//
//  Definition.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation

/// Definition of a word
struct Definition: JSONModel {

    /// Word to define
    var word: String

    /// Definitions of the word
    var definitions: [String]

    /// Date the word was saved
    var saveDate: Date
}
