//
//  GetWords.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import DataRequest

// TODO: Other languages

/// Make `HTTPRequest` for the Dictionary entries API
public struct GetWords: Endpoint {

    /// Response model from the API
    public typealias ResponseBody = [Word]

    /// Code of the language to get the word in
    public var languageCode: String

    /// Word to get definition for
    public var word: String

    /// Public member-wise initializer
    public init(
        languageCode: String = "en",
        word: String
    ) {
        self.languageCode = languageCode
        self.word = word
    }

    /// Endpoint to hit
    public var endpoint: String {
        "entries/\(languageCode)/\(word)"
    }

    /// Get `Word`s and validate the models
    public func requestAndValidate() async throws -> ResponseBody {
        var words = try await request()
        try words.validate()
        return words
    }
}
