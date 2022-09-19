//
//  Entries.swift
//  Define
//
//  Created by Ben Shutt on 19/09/2022.
//

import Foundation

struct Entries: JSONModel {
    var results: [Result]
}

// MARK: - Entries.Result

extension Entries {
    struct Result: Codable {
        var id: String
        var language: String
        var type: String
        var word: String
        var lexicalEntries: [LexicalEntry]
    }
}

// MARK: - Entries.Result.LexicalEntry

extension Entries.Result {
    struct LexicalEntry: Codable {
        var entries: [Entry]
    }
}

// MARK: - Entries.Result.LexicalEntry.Entry

extension Entries.Result.LexicalEntry {
    struct Entry: Codable {
        var senses: [Sense]
    }
}

// MARK: - Entries.Result.LexicalEntry.Entry.Sense

extension Entries.Result.LexicalEntry.Entry {
    struct Sense: Codable {
        var id: String
        var definitions: [String]
    }
}
