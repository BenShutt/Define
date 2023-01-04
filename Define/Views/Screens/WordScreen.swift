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

    /// `Word` to define
    var word: Word

    /// Is the word currently saved
    private var isWordSaved: Bool {
        words.contains(word)
    }

    /// `View` of the screen
    var screen: some View {
        Group {
            if word.meanings.isEmpty {
                SearchEmptyView(
                    lottie: .searchNoResults,
                    title: .WordScreen.Empty.title,
                    subtitle: .WordScreen.Empty.subtitle(word: word.title)
                )
            } else if !isWordSaved {
                StickyButton(buttonText: .WordScreen.saveButton) {
                    saveWord()
                } content: {
                    DefinitionsView(word: word)
                }
            } else {
                DefinitionsView(word: word)
            }
        }
        .navigationTitle(word.title)
        .navigationBarTitleDisplayMode(.inline)
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
        vibrateWithSuccessAndPopToRoot()
    }

    /// Delete `word`
    private func deleteWord() {
        guard words.deleteWord(word) else { return }
        vibrateWithSuccessAndPopToRoot()
    }

    /// Vibrate with success and pop to root
    private func vibrateWithSuccessAndPopToRoot() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        navigation.path = NavigationPath() // Pop to root
    }
}

// MARK: - DefinitionsView

/// Draws a list of definitions
struct DefinitionsView: View {

    /// The word to define
    var word: Word

    /// Draw `View`
    var body: some View {
        ListView(word.meanings) { index, meaning in
            VStack(alignment: .leading, spacing: 0) {
                MeaningListItemView(number: index + 1, meaning: meaning)
            }
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
