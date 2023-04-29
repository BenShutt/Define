//
//  MeaningListItem.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Meaning`
struct MeaningListItem: View {

    /// `Meaning`
    var meaning: Word.Meaning

    /// Title of the definitions label
    private var definitionsTitle: String {
        .MeaningListItemView.definitions(count: meaning.definitions.count)
    }

    /// Draw `View`
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: definitionsTitle)
                .h3()
                .padding(.bottom, .large)

            ForEach(meaning.definitions.zipped, id: \.index) { index, definition in
                VStack(alignment: .leading, spacing: 0) {
                    if index > 0 {
                        Separator()
                            .opacity(0.5)
                            .padding(.vertical, .mediumLarge)
                    }

                    DefinitionListItem(definition: definition)
                }
            }

            WordCategoryView(category: meaning.category)
                .padding(.top, .mediumLarge)
        }
        .listItem()
        .padding(.meaning)
        .background(Color.appWhite)
    }
}

// MARK: - PreviewProvider

struct MeaningListItem_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            if let meaning = Word.preview.meanings.first {
                MeaningListItem(meaning: meaning)
            }
        }
    }
}
