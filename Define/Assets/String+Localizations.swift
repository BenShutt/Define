//
//  String+Localizations.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import Foundation

extension String {

    struct EnterWordScreen {

        static let prompt = "Enter word to search..."
        static let enterWord = "Enter a word in the search field above to look up its definition..."

        static func empty(_ word: String) -> String {
            "No definitions found for the search: '\(word)'"
        }
    }
}
