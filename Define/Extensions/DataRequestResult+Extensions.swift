//
//  DataRequestResult+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import HTTPRequest

extension DataRequestResult {

    /// Map to `Result` with `Model`
    /// - Returns: `Result<Model, Error>`
    func modelResult<Model: Codable>() -> Result<Model, Error> {
        modelResult(decoder: JSONDecoder())
    }

    /// Map to `DictionaryResult`
    var dictionaryResult: Result<Words, Error> {
        modelResult()
    }
}
