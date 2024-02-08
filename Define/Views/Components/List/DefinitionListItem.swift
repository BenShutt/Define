//
//  DefinitionListItem.swift
//  Define
//
//  Created by Ben Shutt on 01/01/2023.
//

import SwiftUI
import DictionaryAPI

/// Draw a definition with an example
struct DefinitionListItem: View {

    @State private var isExpanded = false
    var definition: Word.Meaning.Definition

    var body: some View {
        if definition.exampleTitle != nil {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }, label: {
                DefinitionContentView(
                    isExpanded: isExpanded,
                    definition: definition
                )
            })
        } else {
            DefinitionContentView(
                isExpanded: isExpanded,
                definition: definition
            )
        }
    }
}

// MARK: - DefinitionContentView

private struct DefinitionContentView: View {

    var isExpanded: Bool
    var definition: Word.Meaning.Definition

    private var example: String? {
        definition.exampleTitle
    }

    var body: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: .small) {
                Text(verbatim: definition.title)
                    .body()

                if let example, isExpanded {
                    Text("definition_example \(example)")
                        .foregroundColor(.appBlue)
                        .caption()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if example != nil {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: 12))
                    .foregroundColor(Color.appDarkGray)
            }
        }
        .listItem()
    }
}

// MARK: - Preview

#Preview {
    VStack {
        if let definition = Word.preview.meanings.first?.definitions.first {
            DefinitionListItem(definition: definition)
        }
        Spacer()
    }
    .padding()
    .screen()
}
