//
//  String+Localizations.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import Foundation

// swiftlint:disable nesting

extension String {

    struct SearchHeaderView {

        static let title = "Look Up Word"
        static let subtitle = "Defintions are provided by the Oxford Dictionaries API"
        static let prompt = "Enter word to search..."
    }

    struct WordScreen {

        static let saveButton = "SAVE WORD"

        struct Empty {

            static let title = "No Definitions"

            static func subtitle(word: String) -> String {
                "No definitions were found for: '\(word)'"
            }
        }

        struct Error {

            static let title = "Error"
            
            static func subtitle(word: String) -> String {
                "Failed to load words for: '\(word)'"
            }
        }
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

    struct WordListItemView {

        static func matchType(_ matchType: String) -> String {
            "Match Type: \(matchType)"
        }

        static func score(_ score: String) -> String {
            "Score: \(score)"
        }
    }
}
