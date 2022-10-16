//
//  Word+Preview.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import Foundation

extension Word {

    /// Preview content for `Word`
    static var preview: Word {
        Word(
            id: "word",
            label: "label",
            matchString: "matchString",
            matchType: "matchType",
            score: 1.234_56,
            word: "word"
        )
    }
}
