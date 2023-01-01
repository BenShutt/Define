//
//  DefinitionView.swift
//  Define
//
//  Created by Ben Shutt on 01/01/2023.
//

import SwiftUI
import DictionaryAPI

/// Draw a definition with an example
struct DefinitionView: View {

    /// Definition of a word
    var definition: Word.Meaning.Definition

    /// Example
    var example: String? {
        definition.example?.trimmed.nilIfEmpty?.capitalized
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text(definition.definition.capitalized)
                .body()

            if let example {
                Text(String.DefinitionView.example(example))
                    .caption()
            }
        }
        .listItem()
    }
}

// MARK: - PreviewProvider

struct DefinitionView_Previews: PreviewProvider {

    static var previews: some View {
        if let definition = Word.preview.meanings.first?.definitions.first {
            DefinitionView(definition: definition)
        }
    }
}
