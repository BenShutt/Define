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
            Text(meaning.partOfSpeechTitle)
                .textStyle(.h4, fill: .center)
                .padding(.medium)
                .background(GradientBlurView(
                    color: meaning.category?.backgroundColor ?? .appLightGray
                ))

            ForEach(meaning.definitions.zipped, id: \.0) { _, definition in
                VStack(spacing: 0) {
                    Separator(color: .separator)
                    DefinitionListItem(definition: definition)
                }
            }
        }
        .background(Color.appWhite)
    }
}

// MARK: - Preview

#Preview {
    WordPreviewView(word: "hello") { word in
        if let meaning = word.meanings.first {
            MeaningListItem(meaning: meaning)
        }
    }
    .screen()
}
