//
//  License.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 30/12/2022.
//

import Foundation

public struct License: JSONModel, Validated {

    public var name: String
    public var url: URL?

    public mutating func validate() throws {
        try name.validate()
        // url already validated
    }
}
