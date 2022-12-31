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

    /// Definitions for word
    var definitions: [String] {
        word.definitions
    }

    /// Is the word currently saved
    var isWordSaved: Bool {
        words.contains(word)
    }

    /// `View` of the screen
    var screenBody: some View {
        Group {
            if definitions.isEmpty {
                SearchEmptyView(
                    lottie: .searchNoResults,
                    title: .WordScreen.Empty.title,
                    subtitle: .WordScreen.Empty.subtitle(word: word.word)
                )
            } else if !isWordSaved {
                StickyButtonScreen(buttonText: .WordScreen.saveButton) {
                    saveWord()
                } content: {
                    DefinitionsView(definitions: definitions)
                }
            } else {
                DefinitionsView(definitions: definitions)
            }
        }
        .navigationTitle(word.word)
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
                Text(String.WordScreen.DeleteAlert.subtitle(word: word.word))
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

    /// The definitions
    var definitions: [String]

    /// Draw `View`
    var body: some View {
        ListView(definitions) { definition in
            Text(definition)
                .body()
                .listItem()
                .padding(.margins)
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
