//
//  Word.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

struct Word: JSONModel, Comparable, Identifiable {
    var id: String
    var label: String
    var matchString: String
    var matchType: String
    var region: String?
    var score: Double
    var word: String

    /// Title text
    var title: String {
        word.capitalized
    }

    // MARK: - Comparable

    static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.score < rhs.score
    }
}