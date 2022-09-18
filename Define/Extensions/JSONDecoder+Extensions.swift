//
//  JSONDecoder+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

extension JSONDecoder {

    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    static var snakeCase: JSONDecoder {
        let decoder = JSONDecoder.default
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
