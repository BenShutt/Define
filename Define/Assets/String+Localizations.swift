//
//  String+Localizations.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import Foundation

// swiftlint:disable nesting

extension String {

    struct EnterWordScreen {

        static let prompt = "Enter word to search..."

        static let saveButton = "SAVE WORD"
    }

    struct Search {

        struct Empty {

            static let title = "Start Your Search"

            static let subtitle = "Enter a word into the search field to look up its definition"
        }

        struct NoResults {

            static let title = "No Results"

            static func subtitle(_ word: String) -> String {
                "No definitions found for: '\(word)'"
            }
        }
    }
}
