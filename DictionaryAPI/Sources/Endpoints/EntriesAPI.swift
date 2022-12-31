//
//  EntriesAPI.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import Alamofire

/// Make `HTTPRequest` for the Dictionary entries API
public struct EntriesAPI: DictionaryEndpoint {

    /// Word to get definition for
    public var word: String

    /// Endpoint to hit
    public var endpoint: String {
        "entries/\(String.language)/\(word)"
    }
}

// MARK: - Interface

public extension EntriesAPI {

    /// Fetch definitions for `word`
    /// - Parameter word: `String`
    /// - Returns: `[Word]`
    static func request(word: String) async throws -> [Word] {
        try await EntriesAPI(word: word).request()
    }
}
