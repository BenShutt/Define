//
//  WordListItemView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

/// `ListItemView` for a `Word`
struct WordListItemView: View {

    /// `Word`
    var word: Word

    /// On tap handler
    var onTap: () -> Void

    /// Score as a string
    var score: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter.string(from: word.score as NSNumber) ?? "\(word.score)"
    }

    /// Text of score label
    var scoreText: String {
        .WordListItemView.score(score)
    }

    /// Text of match-type label
    var matchTypeText: String {
        .WordListItemView.matchType(word.matchType.capitalized)
    }

    /// Draw `View`
    var body: some View {
        ListItemView(onTap: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                Text(word.word.capitalized)
                    .h2()

                Spacer()
                    .frame(height: .small)

                Text(matchTypeText)
                    .body()

                Spacer()
                    .frame(height: .medium)

                TagView(text: scoreText)
            }
            .padding(.large)
            .background(Color.appWhite)
        }
    }
}

// MARK: - PreviewProvider

struct WordListItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            WordListItemView(word: .init(
                id: "",
                label: "label",
                matchString: "matchString",
                matchType: "matchType",
                score: 1.234_56,
                word: "word"
            ), onTap: {})
        }
        .listStyle(PlainListStyle())
    }
}
