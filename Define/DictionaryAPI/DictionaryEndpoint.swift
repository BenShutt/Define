//
//  DictionaryEndpoint.swift
//  Define
//
//  Created by Ben Shutt on 17/12/2022.
//

import Foundation
import Alamofire
import HTTPRequest

/// A `HTTPRequestable` for a dictionary endpoint
protocol DictionaryEndpoint: HTTPRequestable {

    /// `HTTPMethod`
    var method: HTTPMethod { get }

    /// Endpoint (path)
    var endpoint: String { get }

    /// `URLQueryItem`s
    var queryItems: [URLQueryItem] { get }

    /// Additional `HTTPHeaders`
    var additionalHeaders: HTTPHeaders { get }

    /// Make request body
    func body() throws -> Data?
}

// MARK: - Extensions

extension DictionaryEndpoint {

    /// Defaults to `.get`
    var method: HTTPMethod {
        .get
    }

    /// Defaults to empty
    var queryItems: [URLQueryItem] {
        []
    }

    /// Defaults to empty (no additional)
    var additionalHeaders: HTTPHeaders {
        HTTPHeaders()
    }

    /// Default additional headers for dictionary API
    var dictionaryHeaders: HTTPHeaders {
        HTTPHeaders([.acceptJSON, .appId, .appKey]) // Currently always accept JSON
    }

    /// Defaults to `nil`
    func body() throws -> Data? {
        nil
    }

    /// Make `HTTPRequest`
    func httpRequest() throws -> HTTPRequest {
        try HTTPRequest(
            method: method,
            urlComponents: .dictionaryAPI(endpoint: endpoint, queryItems: queryItems),
            additionalHeaders: dictionaryHeaders.appending(additionalHeaders),
            body: body()
        )
    }
}
