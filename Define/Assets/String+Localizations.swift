//
//  String+Localizations.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import Foundation

// swiftlint:disable nesting

extension String {

    struct WelcomeScreen {

        static func title(appName: String) -> String {
            "Welcome to \(appName)"
        }
    }

    struct SearchHeaderView {

        static let title = "Search Word"
        static let subtitle = "Definitions are provided by the [Free Dictionary API](https://dictionaryapi.dev/)."
        static let prompt = "Enter a word..."
    }

    struct HomeScreen {

        static let title = "Your Words"
        static let subtitle = "Search for a new word, or revisit what you have previously saved."
        static let addWordButton = "SEARCH FOR WORD"
    }

    struct SearchScreen {

        static let title = "Search"

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

    struct DefinitionView {

        static func example(_ example: String) -> String {
            "Example: \(example)"
        }
    }

    struct WordListItemView {

        static func nMoreDefinitions(_ count: Int) -> String {
            "+\(count) more definitions"
        }
    }

    struct WordScreen {

        static let saveButton = "SAVE WORD"

        struct Empty {

            static let title = "No Definitions"

            static func subtitle(word: String) -> String {
                "No definitions were found for: '\(word)'"
            }
        }

        struct DeleteAlert {

            static let title = "Delete Word"
            static let delete = "Delete"

            static func subtitle(word: String) -> String {
                "Are you sure you want to delete the word: '\(word)'"
            }
        }
    }

    struct SavedWord {

        static let justNow = "Just Now"

        static func addedAgo(_ interval: String) -> String {
            "Added \(interval) ago"
        }
    }

    struct Misc {

        static let dismiss = "Dismiss"
    }

    struct Push {

        static func title(word: String) -> String {
            "Word Reminder 🕔: \(word)"
        }

        static let subtitle = "Hopefully this helps your remember it"
    }
}

// swiftlint:enable nesting
