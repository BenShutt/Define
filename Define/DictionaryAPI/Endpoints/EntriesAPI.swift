//
//  EntriesAPI.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import Alamofire
import HTTPRequest

/// Make `HTTPRequest` for the Dictionary entries API
struct EntriesAPI: DictionaryEndpoint {

    /// Word identifier to get entry for
    var wordId: String

    /// Endpoint to hit
    var endpoint: String {
        "entries/\(String.language)/\(wordId.lowercased())"
    }

    /// `URLQueryItem`s
    ///
    /// - "fields": A comma-separated list of data fields to return for the matched entries
    /// - "strictMatch": Specifies whether diacritics must match exactly
    var queryItems: [URLQueryItem] {
        [
            .init(name: "fields", value: "definitions"),
            .init(name: "strictMatch", value: "true")
        ]
    }
}
