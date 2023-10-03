//
//  Endpoint.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 25/09/2023.
//

import Foundation
import Alamofire
import DataRequest

public protocol Endpoint: DecodableRequest {

    var endpoint: String { get }
    var queryItems: [URLQueryItem] { get }
}

public extension Endpoint {

    var queryItems: [URLQueryItem] {
        []
    }

    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.dictionaryapi.dev"
        urlComponents.path = "/api/v2/\(endpoint)"
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        return urlComponents
    }

    var decoder: DataDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
