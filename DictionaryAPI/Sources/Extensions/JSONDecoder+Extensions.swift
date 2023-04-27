//
//  JSONDecoder+Extensions.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

extension JSONDecoder {

    /// `JSONDecoder` for the API
    static var api: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
