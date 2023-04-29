//
//  WordsScrollView.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI
import DictionaryAPI

/// `ScrollView` of `[Word]`
struct WordsScrollView: View {

    /// `EdgeInsets` to apply as padding around the edge of the cells
    private let margins: EdgeInsets = .margins

    /// The words to list
    var words: [Word]

    /// Additional top margin
    private var topMargin: CGFloat {
        words.isEmpty ? 0 : margins.top * 0.5
    }

    /// Additional bottom margin
    private var bottomMargin: CGFloat {
        words.isEmpty ? 0 : margins.bottom * 0.5
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(words.zipped, id: \.0) { _, word in
                    NavigationLink(.word(word)) {
                        WordListItemView(word: word)
                            .cornerRadius(.cornerRadius)
                            .shadow(.container)
                            .padding(margins)
                    }
                }
            }
            .padding(.top, topMargin)
            .padding(.bottom, bottomMargin)
        }
    }
}

// MARK: - PreviewProvider

struct WordsScrollView_Previews: PreviewProvider {

    static var previews: some View {
        WordsScrollView(words: [.preview])
    }
}
