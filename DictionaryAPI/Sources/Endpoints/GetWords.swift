//
//  GetWords.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import DataRequest

/// Make `HTTPRequest` for the Dictionary entries API
public struct GetWords: Endpoint {

    /// Response model from the API
    public typealias ResponseBody = [Word]

    /// Word to get definition for
    public var word: String

    /// Public member-wise initializer
    public init(word: String) {
        self.word = word
    }

    /// Endpoint to hit
    public var endpoint: String {
        "entries/en/\(word)" // Fixed language for now
    }

    /// Get `Word`s and validate the models
    public func requestAndValidate() async throws -> [Word] {
        var words = try await request()
        try words.validate()
        return words
    }
}
