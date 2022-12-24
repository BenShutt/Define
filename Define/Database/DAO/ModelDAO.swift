//
//  ModelDAO.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation
import RealmSwift

/// A DAO with an associated `DBModel`
protocol ModelDAO {

    /// Database model that maps to an app model
    associatedtype DBModel: Object, MappedDBModel
}

// MARK: - Extensions

extension ModelDAO {

    /// Get all `DBModel`s and map to its associated `DBModel.Model`
    static var models: [DBModel.Model] {
        get throws {
            try RealmDB.realm().objects(DBModel.self).map { $0.model }
        }
    }
}
