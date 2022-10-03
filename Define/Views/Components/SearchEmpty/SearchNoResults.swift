//
//  SearchNoResults.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import Foundation

/// Empty state search UI when the user's searched returned no results
struct SearchNoResults: SearchEmptyView {

    /// The word that was searched
    var word: String

    var lottie: LottieFile {
        .searchNoResults
    }

    var title: String {
        .Search.NoResults.title
    }

    var subtitle: String {
        .Search.NoResults.subtitle(word)
    }
}
