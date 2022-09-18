//
//  Words.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

struct Words: JSONModel {
    var metadata: Metadata
    var results: [Word]
}
