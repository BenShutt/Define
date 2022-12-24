//
//  DBDefinition.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation
import RealmSwift

/// A database record for a `Definiton`
class DBDefinition: Object, MappedDBModel, Identifiable {

    /// The word
    @Persisted var word = ""

    /// Definitions of word
    @Persisted var definitions = RealmList<String>()

    /// Date saved
    @Persisted var saveDate = Date()

    /// Map to app model
    var model: Definition {
        Definition(word: word, definitions: Array(definitions), saveDate: saveDate)
    }

    /// Identifier
    var id: String {
        model.id
    }
}
