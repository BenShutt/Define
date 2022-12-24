//
//  DefinitionDAO.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation
import RealmSwift

/// Data access object to read/write `DBDefinition`s
struct DefinitionDAO: ModelDAO {

    /// Read and write `DBDefinition` models to database
    typealias DBModel = DBDefinition

    /// Save `definition`
    /// - Parameters:
    ///   - definition: `Definition`
    ///   - completion: `RealmDB.Completion`
    static func save(
        definition: Definition,
        completion: RealmDB.Completion? = nil
    ) {
        RealmDB.insert({[
            DBDefinition.make(definition: definition)
        ]}, completion: completion)
    }
}

// MARK: - DBDefinition + Make

extension DBDefinition {

    /// Initialize with `definition`
    /// - Parameter definition: `Definition`
    /// - Returns: `DBDefinition`
    static func make(definition: Definition) -> DBDefinition {
        let model = DBDefinition()
        model.word = definition.word
        model.definitions = .make(definition.definitions)
        model.saveDate = definition.saveDate
        return model
    }
}
