//
//  Metadata.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

struct Metadata: JSONModel {
    var limit: String?
    var offset: String?
    var operation: String?
    var provider: String?
    var schema: String?
    var sourceLanguage: String?
    var total: String
}

// MARK: - Extensions

extension Metadata {

    var intTotal: Int {
        Int(total) ?? -1
    }
}
