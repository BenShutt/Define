//
//  WordListView.swift
//  Define
//
//  Created by Ben Shutt on 04/01/2023.
//

import SwiftUI
import DictionaryAPI

/// `ListView` of `Word` meanings
struct WordListView: View {

    /// The word to define
    var word: Word

    /// Draw `View`
    var body: some View {
        ListView(word.meanings) { index, meaning in
            MeaningListItemView(number: index + 1, meaning: meaning)
        }
    }
}
