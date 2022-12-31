//
//  MeaningListItemView.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Meaning`
struct MeaningListItemView: View {

    /// `Meaning`
    var meaning: Word.Meaning

    /// Title of the definitions label
    private var definitionsTitle: String {
        let isSingular = meaning.definitions.count == 1
        return .MeaningListItemView.definitions(singular: isSingular)
    }

    /// Draw `View`
    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text(definitionsTitle)
                .tag()

            ForEach(values: meaning.definitions) { definition in
                VStack(alignment: .leading, spacing: .small) {
                    Text(definition.definition)
                        .body()

                    if let example = definition.example, !example.isEmpty {
                        Text(String.MeaningListItemView.example)
                            .tag()

                        Text(example)
                            .textStyle(.tag)
                            .foregroundColor(.appDarkGray)
                    }
                }
            }

            TagView(text: meaning.category)
        }
        .listItem()
        .padding(.large)
    }
}

// MARK: - PreviewProvider

struct MeaningListItemView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            if let meaning = Word.preview.meanings.first {
                MeaningListItemView(meaning: meaning)
            }
        }
    }
}
