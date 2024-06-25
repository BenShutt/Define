//
//  MeaningListItem.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import SwiftUI
import DictionaryAPI

struct MeaningListItem: View {
    var meaning: Word.Meaning

    var body: some View {
        VStack(spacing: 0) {
            ForEach(meaning.definitions.zipped, id: \.0) { index, definition in
                VStack(spacing: 0) {
                    if index > 0 {
                        Separator(color: .separator.opacity(0.5))
                            .padding(.vertical, .mediumLarge)
                    }

                    DefinitionListItem(definition: definition)
                }
            }

            WordCategoryView(category: meaning.category)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, .mediumLarge)
        }
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
