//
//  JSONDataRequest.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 16/01/2023.
//

import Foundation
import Alamofire

/// A ForPlanet endpoint
public protocol JSONDataRequest {

    /// Model expected in the response body that will be decoded from JSON.
    /// - Note: `Empty` can be used as the `Model` type when a response is empty.
    associatedtype ResponseBody: Decodable

    /// `HTTPMethod`
    var method: HTTPMethod { get }

    /// Endpoint (path)
    var endpoint: String { get }

    /// `URLQueryItem`s
    var queryItems: [URLQueryItem] { get }

    /// Additional `HTTPHeaders`.
    /// Some headers are set by default, additional ones can be added here
    var additionalHeaders: HTTPHeaders { get }
}

// MARK: - Extensions

public extension JSONDataRequest {

    /// Defaults to `.get`
    var method: HTTPMethod {
        .get
    }

    /// Defaults to empty
    var queryItems: [URLQueryItem] {
        []
    }

    /// Defaults to empty
    var additionalHeaders: HTTPHeaders {
        []
    }

    // MARK: Helper

    /// Get the base HTTP headers
    private var headers: HTTPHeaders {
        var headers: HTTPHeaders = .default
        headers.append(.acceptJSON)
        if let requestBody = self as? RequestBody {
            headers.append(requestBody.contentType)
        }
        return headers
    }

    /// Map to `URLRequest`
    private var urlRequest: URLRequest {
        get throws {
            var request = try URLRequest(
                url: URLComponents.dictionaryAPI(
                    endpoint: endpoint,
                    queryItems: queryItems
                ),
                method: method
            )
            request.timeoutInterval = 45
            request.headers = headers.appending(additionalHeaders)
            if let requestBody = self as? RequestBody {
                request.httpBody = try requestBody.body
            }
            return request
        }
    }

    // MARK: Request

    /// Request and decode `ResponseBody`
    /// - Returns: `ResponseBody`
    @discardableResult
    func request() async throws -> ResponseBody {
        try await AF
            .request(urlRequest)
            .validate()
            .serializingDecodable(ResponseBody.self, decoder: JSONDecoder.api)
            .value
    }
}
