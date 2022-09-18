//
//  DictionaryAPIKey.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import HTTPRequest

/// Load API key from the "dictionary-api-key.txt" file.
struct DictionaryAPIKey {

    /// File with API key
    private static let fileName = "dictionary-api-key.json"

    /// Cache of the API key (static storage)
    private static var apiKeyCache: APIKey?

    /// Get API key
    static var apiKey: APIKey? {
        if apiKeyCache == nil {
            apiKeyCache = try? Self.loadFromFile() // Mask throw
        }
        return apiKeyCache
    }

    /// Load API key from file
    private static func loadFromFile() throws -> APIKey {
        try JSONDecoder.snakeCase.decode(APIKey.self, from: Data(contentsOf: URL
            .findDirectoryOfXcodeProject()
            .appendingPathComponent(fileName))
        )
    }
}
