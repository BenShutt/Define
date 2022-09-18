//
//  SearchAPI.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import Alamofire
import HTTPRequest

/// Make `HTTPRequest` for the Dictionary search API
struct SearchAPI: HTTPRequestable {

    /// Word to search
    var word: String

    /// Additional `HTTPHeaders`
    var headers: HTTPHeaders {
        HTTPHeaders([.acceptJSON, .appId, .appKey])
    }

    /// Endpoint to hit
    var endpoint: String {
        "search/\(String.language)"
    }

    /// `URLQueryItem`s
    var queryItems: [URLQueryItem] {
        [.init(name: "q", value: word)]
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
