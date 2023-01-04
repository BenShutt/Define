//
//  DefinitionsScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct DefinitionsScreen: Screen {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// `NavigationBarStyle`
    var navigationBarStyle: NavigationBarStyle {
        NavigationBarStyle(title: .DefinitionsScreen.title)
    }

    /// Draw view
    var screen: some View {
        StickyButton(buttonText: .DefinitionsScreen.addWordButton) {
            navigation.push(.search)
        } content: {
            ListView(words.words) { _, word in
                AppNavigationLink(value: NavigationRoute.word(word.word)) {
                    WordListItemView(word: word.word)
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct DefinitionScreen_Previews: PreviewProvider {

    static var previews: some View {
        DefinitionsScreen()
            .environmentObject(NavigationViewModel())
            .environmentObject(WordsViewModel())
    }
}
