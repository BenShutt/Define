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
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        return String(decoding: data, as: UTF8.self)
    }

    var description: String {
        (try? jsonString()) ?? ""
    }
}
