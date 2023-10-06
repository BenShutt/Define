//
//  WordListItem.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Word`
struct WordListItem: View {

    /// `Word`
    var word: Word

    /// Caption text
    var caption: String?

    var body: some View {
        HStack(spacing: .large) {
            VStack(alignment: .leading, spacing: .small) {
                Text(verbatim: word.title)
                    .h2()

                if let subtitle = word.subtitle {
                    Text(subtitle)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .body()
                }

                if let nMore = word.nMore {
                    Text(nMore)
                        .textStyle(.body)
                        .foregroundColor(.appBlue)
                }

                if !word.partsOfSpeech.isEmpty {
                    PartsOfSpeechView(partsOfSpeech: word.partsOfSpeech)
                        .padding(.top, .small)
                }

                if let caption {
                    Text(verbatim: caption)
                        .caption()
                        .padding(.top, .small)
                }
            }
            .listItem()

            ChevronView()
        }
        .padding(.large)
        .background(Color.appWhite)
    }
}

// MARK: - PartsOfSpeechView

private struct PartsOfSpeechView: View {

    var partsOfSpeech: [String]

    var body: some View {
        NoBounceScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .small) {
                ForEach(partsOfSpeech, id: \.self) {
                    WordCategoryView(category: $0)
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct WordListItem_Previews: PreviewProvider {

    static var previews: some View {
        WordListItem(word: .preview)
            .screen()
    }
}
