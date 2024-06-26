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
    @Environment(\.popToRoot) private var popToRoot

    /// Is the notification request reminding the user about this word pending (due in the future)
    @State private var isReminderScheduled = false

    /// Is presenting alert to delete word
    @State private var isPresentingDeleteWordAlert = false

    /// Is presenting alert to delete word reminder
    @State private var isPresentingDeleteWordReminderAlert = false

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
        .toolbar(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(verbatim: word.title)
                    .textStyle(.h2)
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
        .stickyTop {
            HeaderView(spacing: 0, padding: .headerPadding) {}
        }
        .deleteWordAlert(
            word: word,
            isPresented: $isPresentingDeleteWordAlert,
            onDelete: {
                deleteWord()
            }
        )
        .deleteWordReminderAlert(
            word: word,
            isPresented: $isPresentingDeleteWordReminderAlert,
            onDelete: {
                ReminderNotification.removePendingRequest(word: word)
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
        popToRoot()
    }

    /// Delete `word`
    private func deleteWord() {
        words.deleteWord(word)
        popToRoot()
    }

    /// Handle reminder button tap
    private func onReminderTapped() {
        if isReminderScheduled {
            isPresentingDeleteWordReminderAlert = true
        } else {
            ReminderNotification.scheduleRequest(word: word)
        }
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
    .environmentObject(WordsViewModel())
}
