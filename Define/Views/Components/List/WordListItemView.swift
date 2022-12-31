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
    var partsOfSpeech: [String] {
        word.meanings.map { $0.partOfSpeech }
    }

    /// The first definition for preview
    var firstDefinition: String? {
        word.definitions.first
    }

    /// The number of (extra) definitions not shown in preview
    var nMore: Int {
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
                    Text(String.WordListItemView.nMore(nMore))
                        .body()
                        .foregroundColor(.appBlue)
                }

                Spacer()
                    .frame(height: .small)

                if !partsOfSpeech.isEmpty {
                    HStack(spacing: .small) {
                        ForEach(values: partsOfSpeech) { partOfSpeech in
                            TagView(text: partOfSpeech)
                        }
                    }
                }
            }
            .listItem()

            ChevronView()
        }
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
