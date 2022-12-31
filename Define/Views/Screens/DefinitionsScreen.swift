//
//  DefinitionsScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct DefinitionsScreen: View {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Draw view
    var body: some View {
        StickyButtonScreen(buttonText: .DefinitionsScreen.addWordButton) {
            navigation.path.append(NavigationRoute.search)
        } content: {
            ListView(words.words) { _, word in
                AppNavigationLink(value: NavigationRoute.word(word.word)) {
                    WordListItemView(word: word.word)
                }
            }
        }
        .navigationTitle(String.DefinitionsScreen.title)
        .navigationBarTitleDisplayMode(.automatic)
    }
}

// MARK: - PreviewProvider

struct DefinitionScreen_Previews: PreviewProvider {

    static var previews: some View {
        DefinitionsScreen()
            .environmentObject(WordsViewModel())
    }
}
