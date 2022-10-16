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
        VStack(alignment: .leading, spacing: 0) {
            Text(word.title)
                .h2()

            Spacer()
                .frame(height: .small)

            Text(matchTypeText)
                .body()

            Spacer()
                .frame(height: .medium)

            TagView(text: scoreText)
        }
        .listItem()
        .padding(.large)
    }
}

// MARK: - PreviewProvider

struct WordListItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WordListItemView(word: .preview)
        }
    }
}
