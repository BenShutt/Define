//
//  WordListItemView.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Word`
struct WordListItemView: View {

    /// `Word`
    var word: Word

    /// Parts of speech
    private var partsOfSpeech: [String] {
        Set(word.meanings.map { $0.category }).sorted()
    }

    /// The first definition for preview
    private var firstDefinition: String? {
        word.definitions.first
    }

    /// The number of (extra) definitions not shown in preview
    private var nMore: Int {
        max(0, word.definitions.count - 1)
    }

    /// Draw `View`
    var body: some View {
        HStack(spacing: .large) {
            VStack(alignment: .leading, spacing: .small) {
                Text(word.title)
                    .h2()

                if let firstDefinition {
                    Text(firstDefinition)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .body()
                }

                if nMore > 0 {
                    Text(String.WordListItemView.nMoreDefinitions(nMore))
                        .textStyle(.body)
                        .foregroundColor(.appBlue)
                }

                if !partsOfSpeech.isEmpty {
                    PartsOfSpeechView(partsOfSpeech: partsOfSpeech)
                        .padding(.top, .small)
                }
            }
            .listItem()

            ChevronView()
        }
        .padding(.large)
        .background(Color.appWhite)
        .cornerRadius(.cornerRadius)
        .shadow(.container)
        .padding(EdgeInsets.margins)
    }
}

// MARK: - PartsOfSpeechView

private struct PartsOfSpeechView: View {

    var partsOfSpeech: [String]

    var body: some View {
        NoBounceScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .small) {
                ForEach(values: partsOfSpeech) {
                    WordCategoryView(category: $0)
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct WordListItemView_Previews: PreviewProvider {

    static var previews: some View {
        ScreenBody {
            WordListItemView(word: .preview)
        }
    }
}
