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

    private var example: String? {
        definition.exampleTitle
    }

    var body: some View {
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }, label: {
            HStack(spacing: .medium) {
                VStack(alignment: .leading, spacing: .small) {
                    Text(verbatim: definition.title)
                        .body()

                    if let example, isExpanded {
                        Text(verbatim: .DefinitionView.example(example))
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
        })
    }
}

// MARK: - PreviewProvider

struct DefinitionListItem_Previews: PreviewProvider {

    static var previews: some View {
        if let definition = Word.preview.meanings.first?.definitions.first {
            VStack {
                DefinitionListItem(definition: definition)
                Spacer()
            }
            .padding()
            .screen()
        }
    }
}
