//
//  ModelResult.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 31/12/2022.
//

import Foundation

/// `Result` with `Success == Model` and `Failure == Error`
public typealias ModelResult<Model> = Result<Model, Error>
