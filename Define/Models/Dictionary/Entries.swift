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
    struct Result: Codable, Identifiable {
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
    struct Sense: Codable, Identifiable {
        var id: String
        var definitions: [String]
    }
}

// MARK: - Extensions

extension Entries {

    /// Map to definitions of words
    var definitions: [String] {
        results
            .flatMap { $0.lexicalEntries }
            .flatMap { $0.entries }
            .flatMap { $0.senses }
            .flatMap { $0.definitions }
    }
}
