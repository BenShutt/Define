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

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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

// MARK: - Preview

#Preview {
    VStack {
        if let meaning = Word.preview.meanings.first {
            MeaningListItem(meaning: meaning)
        }
    }
}
