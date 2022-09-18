//
//  DictionaryAPIKey.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

/// Load API key from the "dictionary-api-key.txt" file.
struct DictionaryAPIKey {

    /// File with API key
    private static let fileName = "dictionary-api-key.txt"

    /// Cache of the API key (static storage)
    private static var apiKeyCache = ""

    /// Get API key
    static var apiKey: String {
        if apiKeyCache.isEmpty {
            apiKeyCache = (try? Self.loadFromFile()) ?? "" // Mask throw
        }
        return apiKeyCache
    }

    /// Load API key from file
    private static func loadFromFile() throws -> String {
        let url = try URL
            .findDirectoryOfXcodeProject()
            .appendingPathComponent(fileName)

        let data = try Data(contentsOf: url)
        return String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
