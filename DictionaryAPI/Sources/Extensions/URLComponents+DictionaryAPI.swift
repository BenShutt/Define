//
//  URLComponents+DictionaryAPI.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

extension URLComponents {

    /// Dictionary API for `endpoint` and `queryItems`
    ///
    /// - Parameters:
    ///   - endpoint: `String`
    ///   - queryItems: `[URLQueryItem]`
    static func dictionaryAPI(
        endpoint: String,
        queryItems: [URLQueryItem] = []
    ) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.dictionaryapi.dev"
        urlComponents.path = "/api/v2/\(endpoint)"
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        return urlComponents
    }
}
