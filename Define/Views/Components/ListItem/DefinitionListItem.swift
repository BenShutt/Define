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
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }, label: {
            DefinitionView(
                isExpanded: isExpanded,
                definition: definition
            )
        })
        .disabled(definition.exampleTitle == nil)
    }
}

// MARK: - DefinitionView

private struct DefinitionView: View {
    var isExpanded: Bool
    var definition: Word.Meaning.Definition

    private var example: String? {
        definition.exampleTitle
    }

    var body: some View {
        HStack(spacing: .medium) {
            VStack(spacing: .small) {
                Text(definition.title)
                    .textStyle(.body, fill: .leading)

                if let example, isExpanded {
                    Text("definition_example \(example)")
                        .foregroundStyle(Color.appBlue) // Override
                        .textStyle(.caption, fill: .leading)
                }
            }

            if example != nil {
                Image(isExpanded ? .chevronUp : .chevronDown)
                    .systemImage(size: 12)
                    .foregroundStyle(Color.appDarkGray)
                    .accessibilityHidden(true)
            }
        }
        .padding(.margins)
    }
}

// MARK: - Preview

#Preview {
    WordPreviewView(word: "hello") { word in
        if let definition = word.meanings.first?.definitions.first {
            DefinitionListItem(definition: definition)
        }
    }
    .screen()
}
