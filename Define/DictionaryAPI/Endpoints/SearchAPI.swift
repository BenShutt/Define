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
struct SearchAPI: DictionaryEndpoint {

    /// Word to search
    var word: String

    /// Endpoint to hit
    var endpoint: String {
        "search/\(String.language)"
    }

    /// `URLQueryItem`s
    var queryItems: [URLQueryItem] {
        [.init(name: "q", value: word)]
    }
}
