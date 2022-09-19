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
struct EntriesAPI: HTTPRequestable {

    /// Word identifier to get entry for
    var wordId: String

    /// Additional `HTTPHeaders`
    var headers: HTTPHeaders {
        HTTPHeaders([.appId, .appKey])
    }

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
            URLQueryItem(name: "fields", value: "definitions"),
            URLQueryItem(name: "strictMatch", value: "true")
        ]
    }

    /// Make `HTTPRequest`
    func httpRequest() throws -> HTTPRequest {
        HTTPRequest(
            method: .get,
            urlComponents: .dictionaryAPI(endpoint: endpoint, queryItems: queryItems),
            additionalHeaders: headers,
            body: nil
        )
    }
}
