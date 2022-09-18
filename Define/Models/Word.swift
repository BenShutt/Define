//
//  Word.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

struct Word: JSONModel {
    var id: String
    var label: String
    var matchString: String
    var matchType: String
    var region: String
    var score: Double
    var word: String
}
