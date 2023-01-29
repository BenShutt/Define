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

    /// Index of `Meaning` in `Word`
    var number: Int

    /// `Meaning`
    var meaning: Word.Meaning

    /// Title of the definitions label
    private var definitionsTitle: String {
        .MeaningListItemView.definitions(count: meaning.definitions.count)
    }

    /// Draw `View`
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(definitionsTitle)
                .h3()

            VSpacer(height: .large)

            ForEach(meaning.definitions.zipped, id: \.index) { index, definition in
                VStack(alignment: .leading, spacing: 0) {
                    if index > 0 {
                        Separator()
                            .opacity(0.5)
                            .padding(.vertical, .mediumLarge)
                    }

                    DefinitionView(definition: definition)
                }
            }

            VSpacer(height: .mediumLarge)
            WordCategoryView(category: meaning.category)
        }
        .listItem()
        .padding(.meaning)
    }
}

// MARK: - PreviewProvider

struct MeaningListItemView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            if let meaning = Word.preview.meanings.first {
                MeaningListItemView(number: 1, meaning: meaning)
            }
        }
    }
}
