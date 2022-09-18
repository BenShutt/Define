//
//  JSONModel.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

protocol JSONModel: Codable, CustomStringConvertible {}

extension JSONModel {

    func jsonString() throws -> String {
        try String(
            decoding: JSONEncoder.pretty.encode(self),
            as: UTF8.self
        )
    }

    var description: String {
        (try? jsonString()) ?? ""
    }
}
