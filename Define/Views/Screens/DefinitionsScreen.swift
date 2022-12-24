//
//  DefinitionsScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI
import RealmSwift

/// Screen listing the user's saved definitions
struct DefinitionsScreen: View {

    /// `DBDefinition`s
    @ObservedResults(DBDefinition.self) var definitions

    /// Draw view
    var body: some View {
        List(definitions.map { $0.model }) { definition in
            Text(definition.word)
        }
        .navigationTitle(String.DefinitionsScreen.title)
        .toolbar {
            ToolbarItem {
                NavigationLink(value: NavigationRoute.search) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct DefinitionScreen_Previews: PreviewProvider {

    static var previews: some View {
        DefinitionsScreen()
    }
}
