//
//  DictionaryEndpoint.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 17/12/2022.
//

import Foundation
import Alamofire

/// A dictionary endpoint
public protocol DictionaryEndpoint {

    /// `HTTPMethod`
    var method: HTTPMethod { get }

    /// Endpoint (path)
    var endpoint: String { get }

    /// `URLQueryItem`s
    var queryItems: [URLQueryItem] { get }

    /// Additional `HTTPHeaders`
    var additionalHeaders: HTTPHeaders { get }

    /// Make request body
    var body: Data? { get throws }
}

// MARK: - Extensions

public extension DictionaryEndpoint {

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
        HTTPHeaders([
            HTTPHeader(name: "Accept", value: "application/json")
        ])
    }

    /// Defaults to `nil`
    var body: Data? {
        nil
    }

    /// Map to `URLRequest`
    var urlRequest: URLRequest {
        get throws {
            var request = try URLRequest(
                url: URLComponents.dictionaryAPI(endpoint: endpoint, queryItems: queryItems),
                method: method
            )
            request.headers = .default.appending(additionalHeaders)
            request.httpBody = try body
            return request
        }
    }

    /// Request and decode `Model`
    /// - Returns: `Model`
    func request<Model: Decodable>() async throws -> Model {
        try await AF
            .request(urlRequest)
            .validate()
            .serializingDecodable(Model.self, decoder: JSONDecoder.default)
            .value
    }
}
