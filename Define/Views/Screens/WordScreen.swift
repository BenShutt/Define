//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI
import NavigationBar

/// `View` to input a word to search for definitions
struct WordScreen: View {

    /// `NavigationViewModel`
    @EnvironmentObject var navigation: NavigationViewModel

    /// `WordsViewModel`
    @EnvironmentObject var words: WordsViewModel

    /// Is the notification request reminding the user about this word pending (due in the future)
    @State private var isReminderScheduled = false

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

    /// Padding for the header view
    private var headerPadding: EdgeInsets {
        var padding: EdgeInsets = .header
        padding.top = .extraSmall
        padding.bottom = .extraSmall
        return padding
    }

    var body: some View {
        WordContentView(
            word: word,
            isWordSaved: isWordSaved
        ) {
            saveWord()
        }
        .screen()
        .modifier(StickyTop {
            HeaderView(spacing: 0, padding: headerPadding) {}
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(verbatim: word.title)
                    .h2()
            }

            if isWordSaved {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        onReminderTapped()
                    }, label: {
                        Image(systemName: isReminderScheduled ? "checkmark" : "clock")
                    })
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresentingDeleteWordAlert = true
                    }, label: {
                        Image(systemName: "trash")
                    })
                }
            }
        }
        .alert(
            Text("word_delete_title"),
            isPresented: $isPresentingDeleteWordAlert,
            actions: {
                Button(role: .destructive) {
                    deleteWord()
                } label: {
                    Text("word_delete_button")
                }
            },
            message: {
                Text("word_delete_subtitle \(word.title)")
            }
        )
        .alert(
            Text("word_reminder_delete_title"),
            isPresented: $isPresentingReminderAlert,
            actions: {
                Button(role: .destructive) {
                    ReminderNotification.removePendingRequest(word: word)
                } label: {
                    Text("delete")
                }

                Button(role: .cancel) {} label: {
                    Text("cancel")
                }
            },
            message: {
                Text("word_reminder_delete_subtitle \(word.title)")
            }
        )
        .modifier(WordReminderObserver(
            isReminderScheduled: $isReminderScheduled,
            word: word
        ))
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
    private func onReminderTapped() {
        if isReminderScheduled {
            isPresentingReminderAlert = true
        } else {
            ReminderNotification.scheduleRequest(word: word)
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
                title: "word_empty_title",
                subtitle: "word_empty_subtitle \(word.title)"
            )
        } else if !isWordSaved {
            MarginedList(word.meanings.identified, isAnimated: true) { item in
                MeaningListItem(meaning: item.element)
            }
            .stickyButton(
                title: "word_save_button",
                systemName: "plus",
                onTap: onSave
            )
        } else {
            MarginedList(word.meanings.identified, isAnimated: true) { item in
                MeaningListItem(meaning: item.element)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        WordScreen(word: .init(word: "hello"))
    }
    .environmentObject(NavigationViewModel())
    .environmentObject(WordsViewModel())
}
