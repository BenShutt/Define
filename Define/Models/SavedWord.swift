//
//  SavedWord.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 26/12/2022.
//

import SwiftUI
import DictionaryAPI

// TODO: Migrate to SwiftData

typealias SavedWordId = UUID

/// A saved word
struct SavedWord: JSONModel, Identifiable, Comparable {

    /// `UUID`
    var id = SavedWordId()

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
    var addedSince: LocalizedStringKey {
        let minutes = Calendar.current.dateComponents(
            [.minute],
            from: savedDate,
            to: .now
        ).minute ?? 0

        guard minutes > 0 else { return "added_just_now" }
        let formatter = DateComponentsFormatter.timeInterval
        let formatted = formatter.string(from: savedDate, to: .now) ?? ""
        return "added \(formatted)"
    }
}
