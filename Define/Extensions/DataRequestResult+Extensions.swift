//
//  DataRequestResult+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import HTTPRequest

/// Result of `Model` and `Error`
typealias ModelResult<Model> = Result<Model, Error>

extension DataRequestResult {

    /// Map to `Result` with `Model`
    /// - Returns: `Result<Model, Error>`
    func modelResult<Model: Codable>() -> ModelResult<Model> {
        modelResult(decoder: JSONDecoder())
    }
}
