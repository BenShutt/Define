//
//  WordDb.swift
//  Define
//
//  Created by Ben Shutt on 01/07/2024.
//

import Foundation
import SwiftData

struct WordDb {
    let modelContext: ModelContext

    func fetchAll() throws -> [SavedWord] {
        try modelContext.fetch(FetchDescriptor<SavedWord>())
    }

    func fetch(word: String) throws -> SavedWord? {
        try modelContext.fetch(
            FetchDescriptor<SavedWord>(predicate: #Predicate {
                $0.word == word // Word properties are lowercase
            })
        ).first
    }

    func fetchOrNil(word: String) -> SavedWord? {
        do {
            return try fetch(word: word)
        } catch {
            log(error: error)
            return nil
        }
    }
}
