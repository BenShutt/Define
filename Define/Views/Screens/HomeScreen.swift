//
//  HomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// Screen listing the user's saved definitions
struct HomeScreen: Screen {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Draw view
    var screen: some View {
        ScrollVStack(elements: words.words) { word in
            NavigationLink(.word(word.word)) {
                WordListItemView(word: word.word)
            }
        }
        .stickyHeader(
            title: .HomeScreen.title,
            subtitle: .HomeScreen.subtitle
        )
        .stickyButton(
            title: .HomeScreen.addWordButton,
            image: .search
        ) {
            navigation.push(.search)
        }
        .navigationBarHidden(true)
        .navigationTitle(String.HomeScreen.title) // For back menu
    }
}

// MARK: - PreviewProvider

struct HomeScreen_Previews: PreviewProvider {

    static var previews: some View {
        HomeScreen()
            .environmentObject(NavigationViewModel())
            .environmentObject(WordsViewModel())
    }
}
