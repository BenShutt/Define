//
//  DefinitionsScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct DefinitionsScreen: View {

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Draw view
    var body: some View {
        List(words.words) { word in
            Text(word.word)
        }
        .navigationTitle(String.DefinitionsScreen.title)
        .navigationBarTitleDisplayMode(.automatic)
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
