//
//  Metadata.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

struct Metadata: JSONModel {
    var offset: String
    var limit: String
    var total: String
    var operation: String?
    var provider: String?
    var schema: String?
    var sourceLanguage: String?
}

// MARK: - Extensions

extension Metadata {

    var intOffset: Int {
        Int(offset) ?? -1
    }

    var intLimit: Int {
        Int(limit) ?? -1
    }

    var intTotal: Int {
        Int(total) ?? -1
    }
}
