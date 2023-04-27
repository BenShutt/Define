//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `View` to input a word to search for definitions
struct WordScreen: Screen {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Is presenting alert to delete word
    @State private var showingDeleteWordAlert = false

    /// `NavigationBarStyle`
    var navigationBarStyle: NavigationBarStyle {
        NavigationBarStyle(title: word.title)
    }

    /// `Word` to define
    var word: Word

    /// Is the word currently saved
    private var isWordSaved: Bool {
        words.contains(word)
    }

    /// `View` of the screen
    var screen: some View {
        WordContentView(
            word: word,
            isWordSaved: isWordSaved
        ) {
            saveWord()
        }
        .toolbar {
            if isWordSaved {
                Button(action: {
                    showingDeleteWordAlert = true
                }, label: {
                    Image(systemName: "trash")
                })
            }
        }
        .alert(
            Text(String.WordScreen.DeleteAlert.title),
            isPresented: $showingDeleteWordAlert,
            actions: {
                Button(role: .destructive) {
                    deleteWord()
                } label: {
                    Text(String.WordScreen.DeleteAlert.delete)
                }
            },
            message: {
                Text(String.WordScreen.DeleteAlert.subtitle(word: word.title))
            }
        )
    }

    /// Save `word`
    private func saveWord() {
        words.saveWord(word)
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        navigation.popToRoot()
    }

    /// Delete `word`
    private func deleteWord() {
        guard words.deleteWord(word) else { return }
        navigation.popToRoot()
    }
}

// MARK: - WordContentView

private struct WordContentView: View {

    var word: Word
    var isWordSaved: Bool
    var onSave: () -> Void

    var body: some View {
        if word.meanings.isEmpty {
            SearchEmptyView(
                lottie: .searchNoResults,
                title: .WordScreen.Empty.title,
                subtitle: .WordScreen.Empty.subtitle(word: word.title)
            )
        } else if !isWordSaved {
            WordListView(word: word)
                .modifier(StickyButton(
                    title: .WordScreen.saveButton,
                    image: Image(systemName: "plus"),
                    onTap: onSave
                ))
        } else {
            WordListView(word: word)
        }
    }
}

// MARK: - PreviewProvider

struct WordScreen_Previews: PreviewProvider {

    static var previews: some View {
        WordScreen(word: .preview)
            .environmentObject(NavigationViewModel())
            .environmentObject(WordsViewModel())
    }
}
