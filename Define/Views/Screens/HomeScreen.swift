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
        MarginedList(words.words, route: {
            .word($0.word)
        }, content: {
            WordListItem(word: $0.word)
        })
        .stickyHeader(
            title: .HomeScreen.title,
            subtitle: .HomeScreen.subtitle,
            color: .appGreen
        )
        .stickyButton(
            title: .HomeScreen.addWordButton,
            image: .search
        ) {
            navigation.push(.search)
        }
        .toolbarBackground(Color.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
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
