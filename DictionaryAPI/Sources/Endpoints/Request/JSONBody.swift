//
//  JSONBody.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 06/02/2023.
//

import Foundation
import Alamofire

/// An entity that has a JSON request body
protocol JSONBody: RequestBody {

    /// The request body that will be encoded into JSON data
    associatedtype Body: JSONModel

    /// Make request body that will be decoded into JSON data
    var jsonBody: Body { get }
}

// MARK: - Extensions

extension JSONBody {

    /// Content type JSON
    var contentType: HTTPHeader {
        .contentTypeJSON
    }

    /// JSON body
    var body: Data {
        get throws {
            try JSONEncoder.api.encode(jsonBody)
        }
    }
}
