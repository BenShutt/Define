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

    /// Draw view
    var screen: some View {
        ListView(words.words) { _, word in
            AppNavigationLink(value: NavigationRoute.word(word.word)) {
                WordListItemView(word: word.word)
            }
        }
        .stickyButton(
            title: .DefinitionsScreen.addWordButton,
            image: .search
        ) {
            navigation.push(.search)
        }
        .toolbarBackground(Color.appWhite, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle(String.DefinitionsScreen.title)
        .toolbar {
            Button(action: {
                navigation.push(.search)
            }, label: {
                Image.search
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(size: .iconSize)
                    .padding(.small)
            })
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
