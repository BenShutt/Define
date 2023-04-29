//
//  SavedWord.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 26/12/2022.
//

import Foundation
import DictionaryAPI

/// A saved word
struct SavedWord: JSONModel, Identifiable, Comparable {

    /// `UUID`
    var id = UUID()

    /// The word that was saved
    var word: Word

    /// `Date`
    var savedDate = Date()

    // MARK: - Comparable

    static func < (lhs: SavedWord, rhs: SavedWord) -> Bool {
        lhs.savedDate < rhs.savedDate
    }
}

// MARK: - Extensions

extension SavedWord {

    /// Formatted string of how long ago the word was saved
    var addedSince: String {
        guard Calendar.current.minutes(from: savedDate, to: .now) > 0 else {
            return .SavedWord.justNow
        }

        let formatter = DateComponentsFormatter.timeInterval
        return .SavedWord.addedAgo(formatter.string(
            from: savedDate,
            to: .now
        ) ?? "")
    }
}
