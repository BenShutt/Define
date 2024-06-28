//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

// TODO: Spacing should be the same between meanings and words (home and here)

/// `View` to input a word to search for definitions
struct WordScreen: View {
    @EnvironmentObject private var words: WordsViewModel
    @EnvironmentObject private var manager: NotificationManager
    @Environment(\.popToRoot) private var popToRoot

    /// The date the notification request reminding the user about this word is due
    @State private var reminderDate: Date?

    /// Is presenting alert to delete word
    @State private var isPresentingDeleteWordAlert = false

    /// Is presenting alert to delete word reminder
    @State private var isPresentingDeleteWordReminderAlert = false

    /// `Word` to define
    var word: Word

    /// Get the saved word
    private var savedWord: SavedWord? {
        words.words.first { $0.word == word }
    }

    /// Is the word currently saved
    private var isWordSaved: Bool {
        savedWord != nil
    }

    /// System name of the image for the reminder image
    private var reminderSystemName: String {
        reminderDate != nil ? "checkmark" : "clock"
    }

    var body: some View {
        WordContentView(
            word: word,
            isWordSaved: isWordSaved,
            onSave: addWord
        )
        .screen()
        .toolbar(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(verbatim: word.title)
                    .textStyle(.h2)
            }

            if let savedWord {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        onReminderTapped(savedWord: savedWord)
                    }, label: {
                        Image(systemName: reminderSystemName)
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
        .stickyTop {
            HeaderView(spacing: 0, padding: .headerPadding) {}
        }
        .deleteWordAlert(
            word: word,
            isPresented: $isPresentingDeleteWordAlert,
            onDelete: {
                guard let savedWord else { return }
                removeWord(savedWord: savedWord)
            }
        )
        .deleteWordReminderAlert(
            word: word,
            isPresented: $isPresentingDeleteWordReminderAlert,
            onDelete: {
                guard let savedWord else { return }
                removeWordReminder(savedWordId: savedWord.id)
            }
        )
        .observeWordReminders(
            reminderDate: $reminderDate,
            savedWordId: savedWord?.id
        )
    }

    // MARK: - Buttons

    /// Handle reminder button tap
    /// - Parameter savedWord: The saved word
    private func onReminderTapped(savedWord: SavedWord) {
        if reminderDate != nil {
            isPresentingDeleteWordReminderAlert = true
        } else {
            addWordReminder(savedWord: savedWord)
        }
    }

    // MARK: - Add/Remove WordReminder

    /// Add a word reminder notification
    /// - Parameter savedWord: Saved word to add a reminder for
    private func addWordReminder(savedWord: SavedWord) {
        WordReminder.addRequest(for: savedWord, on: manager)
    }

    /// Remove a word reminder notification
    /// - Parameter savedWord: Saved word to remove a reminder for
    private func removeWordReminder(savedWordId: SavedWordID) {
        WordReminder.removeRequest(for: savedWordId, on: manager)
    }

    // MARK: - Add/Remove SavedWord

    /// Add the word
    private func addWord() {
        let savedWord = SavedWord(word: word, source: .api)
        words.addWord(savedWord)
        addWordReminder(savedWord: savedWord)
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        popToRoot()
    }

    /// Remove the word
    /// - Parameter savedWord: The saved word to remove
    private func removeWord(savedWord: SavedWord) {
        words.removeWord(savedWord)
        removeWordReminder(savedWordId: savedWord.id)
        popToRoot()
    }
}

// MARK: - Alerts

private extension View {
    func deleteWordAlert(
        word: Word,
        isPresented: Binding<Bool>,
        onDelete: @escaping () -> Void
    ) -> some View {
        alert(
            Text("word_delete_title"),
            isPresented: isPresented,
            actions: {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Text("word_delete_button")
                }
            },
            message: {
                Text("word_delete_subtitle \(word.title)")
            }
        )
    }

    func deleteWordReminderAlert(
        word: Word,
        isPresented: Binding<Bool>,
        onDelete: @escaping () -> Void
    ) -> some View {
        alert(
            Text("word_reminder_delete_title"),
            isPresented: isPresented,
            actions: {
                Button(role: .destructive) {
                    onDelete()
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
            MarginedList(
                word.meanings.identified,
                isAnimated: true
            ) { item in
                MeaningListItem(meaning: item.element)
            }
            .stickyButton(
                title: "word_save_button",
                systemName: "plus",
                onTap: onSave
            )
        } else {
            MarginedList(
                word.meanings.identified,
                isAnimated: true
            ) { item in
                MeaningListItem(meaning: item.element)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        WordScreen(word: .init(word: "Preview"))
    }
    .environmentObjects()
}
