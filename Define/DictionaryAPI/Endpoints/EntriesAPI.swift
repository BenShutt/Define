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

    /// Word to get entry for
    var word: String

    /// Additional `HTTPHeaders`
    var headers: HTTPHeaders {
        HTTPHeaders([
            .init(name: "app_id", value: .appId),
            .init(name: "api_key", value: DictionaryAPIKey.apiKey)
        ])
    }

    /// Endpoint to hit
    var endpoint: String {
        "entries\(String.language)/\(word.lowercased())"
    }

    /// Make `HTTPRequest`
    func httpRequest() throws -> HTTPRequest {
        HTTPRequest(
            method: .get,
            urlComponents: .dictionaryAPI(endpoint: endpoint),
            additionalHeaders: headers,
            body: nil
        )
    }
}
