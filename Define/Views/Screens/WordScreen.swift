//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `View` to input a word to search for definitions
struct WordScreen: View, WordReminderObserver {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Is the notification request reminding the user about this word pending (due in the future)
    @State var isReminderScheduled = false // Protocol

    /// Is presenting alert to delete word
    @State private var isPresentingDeleteWordAlert = false

    /// Is presenting alert to remind word
    @State private var isPresentingReminderAlert = false

    /// `Word` to define
    var word: Word

    /// Is the word currently saved
    private var isWordSaved: Bool {
        words.contains(word)
    }

    var body: some View {
        WordContentView(
            word: word,
            isWordSaved: isWordSaved
        ) {
            saveWord()
        }
        .screen()
        .stickyHeader(
            title: word.title,
            topPadding: .medium
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isWordSaved {
                Button(action: {
                    onReminder()
                }, label: {
                    Image(systemName: isReminderScheduled ? "checkmark" : "clock")
                })

                Button(action: {
                    isPresentingDeleteWordAlert = true
                }, label: {
                    Image(systemName: "trash")
                })
            }
        }
        .alert(
            Text(verbatim: .WordScreen.DeleteAlert.title),
            isPresented: $isPresentingDeleteWordAlert,
            actions: {
                Button(role: .destructive) {
                    deleteWord()
                } label: {
                    Text(verbatim: .WordScreen.DeleteAlert.delete)
                }
            },
            message: {
                Text(verbatim: .WordScreen.DeleteAlert.subtitle(word: word.title))
            }
        )
        .alert(
            Text("word_reminder_delete_title"),
            isPresented: $isPresentingReminderAlert,
            actions: {
                Button(role: .destructive) {
                    ReminderNotification.removePendingRequest(word: word)
                    updateReminderAsync(word: word)
                } label: {
                    Text("delete")
                }

                Button(role: .cancel) {
                    // Do nothing
                } label: {
                    Text("cancel")
                }
            },
            message: {
                Text("word_reminder_delete_subtitle \(word.title)")
            }
        )
        .observeWordReminder(
            observer: self,
            word: word,
            words: words
        )
    }

    /// Save `word`
    private func saveWord() {
        words.saveWord(word, source: .api)
        navigation.popToRoot()
    }

    /// Delete `word`
    private func deleteWord() {
        words.deleteWord(word)
        navigation.popToRoot()
    }

    /// Handle reminder button tap
    private func onReminder() {
        if isReminderScheduled {
            isPresentingReminderAlert = true
        } else {
            ReminderNotification.scheduleRequest(word: word)
            updateReminderAsync(word: word)
        }
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
            MarginedList(word.meanings.identified) { indexElement in
                MeaningListItem(meaning: indexElement.element)
            }
            .stickyButton(
                title: .WordScreen.saveButton,
                systemName: "plus",
                onTap: onSave
            )
        } else {
            MarginedList(word.meanings.identified) { indexElement in
                MeaningListItem(meaning: indexElement.element)
            }
        }
    }
}

// MARK: - PreviewProvider

struct WordScreen_Previews: PreviewProvider {

    static var previews: some View {
        WordScreen(word: .init(word: "hello"))
            .environmentObject(NavigationViewModel())
            .environmentObject(WordsViewModel())
    }
}
