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

    /// Delete word message
    var deleteMessage: String {
        .WordScreen.DeleteAlert.subtitle(word: word.word)
    }

    /// Is the word currently saved
    var isWordSaved: Bool {
        words.contains(word)
    }

    /// `View` of the screen
    var screenBody: some View {
        Group {
            if definitions.isEmpty {
                NoDefinitionsView(word: word.word)
            } else if !isWordSaved {
                StickyButtonScreen(buttonText: .WordScreen.saveButton) {
                    saveWord()
                } content: {
                    DefinitionsView(word: word, definitions: definitions)
                }
            } else {
                DefinitionsView(word: word, definitions: definitions)
            }
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
                Text(deleteMessage)
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

    /// Word to define
    var word: Word

    /// The definitions
    var definitions: [String]

    /// Draw `View`
    var body: some View {
        VStack(spacing: 0) {
            Text(word.word)
                .h1()

            ListView(definitions) { definition in
                Text(definition)
                    .body()
                    .listItem()
                    .padding(.margins)
            }
        }
    }
}

// MARK: - NoDefinitionsView

/// Draw empty state when no definitions can be found
private struct NoDefinitionsView: View {

    /// Word that was searched
    var word: String

    /// Title text
    var title: String {
        .WordScreen.Empty.title
    }

    /// Subtitle text
    var subtitle: String {
        .WordScreen.Empty.subtitle(word: word)
    }

    /// Make a `SearchEmptyView`
    var body: some View {
        SearchEmptyView(
            lottie: .searchNoResults,
            title: title,
            subtitle: subtitle
        )
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
