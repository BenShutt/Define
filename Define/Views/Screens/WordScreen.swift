//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import SwiftData
import DictionaryAPI

/// `View` to input a word to search for definitions
struct WordScreen: View {
    @EnvironmentObject private var settings: UserSettings
    @EnvironmentObject private var notifications: NotificationManager
    @Environment(\.modelContext) private var modelContext
    @Environment(\.popToRoot) private var popToRoot

    /// Is presenting alert to delete word
    @State private var isPresentingDeleteWordAlert = false

    /// Is presenting alert to delete word reminder
    @State private var isPresentingDeleteWordReminderAlert = false

    /// Word to define
    var source: WordSource

    var body: some View {
        WordContentView(
            source: source,
            onSave: {
                addWord(savedWord: source.word.savedWord())
            }
        )
        .screen()
        .deleteWordAlert(
            title: source.word.title,
            isPresented: $isPresentingDeleteWordAlert,
            onDelete: {
                guard let savedWord = source.savedWord else { return }
                removeWord(savedWord: savedWord)
            }
        )
        .deleteWordReminderAlert(
            title: source.word.title,
            isPresented: $isPresentingDeleteWordReminderAlert,
            onDelete: {
                guard let savedWord = source.savedWord else { return }
                removeWordReminder(savedWord: savedWord)
            }
        )
        .navigationBar(title: source.word.title)
        .toolbar {
            if let savedWord = source.savedWord {
                ToolbarItem(placement: .topBarTrailing) {
                    WordReminderButton(savedWord: savedWord) { hasReminder in
                        if hasReminder {
                            isPresentingDeleteWordReminderAlert = true
                        } else {
                            addWordReminder(savedWord: savedWord)
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresentingDeleteWordAlert = true
                    }, label: {
                        Image(.trash)
                            .accessibilityHidden(true)
                    })
                }
            }
        }
    }

    // MARK: - Add/Remove WordReminder

    /// Add a word reminder notification
    /// - Parameter savedWord: Word to add a reminder for
    private func addWordReminder(savedWord: SavedWord) {
        WordReminder.addRequest(for: savedWord, on: notifications)
    }

    /// Remove a word reminder notification
    /// - Parameter savedWord: Word to remove a reminder for
    private func removeWordReminder(savedWord: SavedWord) {
        WordReminder.removeRequest(for: savedWord, on: notifications)
    }

    // MARK: - Add/Remove SavedWord

    /// Add the word
    /// - Parameter savedWord: The word to add
    private func addWord(savedWord: SavedWord) {
        modelContext.insert(savedWord)
        if settings.wordReminders {
            addWordReminder(savedWord: savedWord)
        }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        popToRoot()
    }

    /// Remove the word
    /// - Parameter savedWord: The word to remove
    private func removeWord(savedWord: SavedWord) {
        modelContext.delete(savedWord)
        removeWordReminder(savedWord: savedWord)
        popToRoot()
    }
}

// MARK: - Alerts

private extension View {
    func deleteWordAlert(
        title: String,
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
                Text("word_delete_subtitle \(title)")
            }
        )
    }

    func deleteWordReminderAlert(
        title: String,
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
                Text("word_reminder_delete_subtitle \(title)")
            }
        )
    }
}

// MARK: - WordContentView

private struct WordContentView: View {
    var source: WordSource
    var onSave: () -> Void

    var body: some View {
        if source.word.meanings.isEmpty {
            SearchEmptyView(
                lottie: .searchNoResults,
                title: "word_empty_title",
                subtitle: "word_empty_subtitle \(source.word.title)"
            )
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
        } else if !source.isSaved {
            MeaningList(source: source)
                .stickyButton(
                    title: "word_save_button",
                    systemName: .plus,
                    onTap: onSave
                )
        } else {
            VStack(spacing: 0) {
                WordSavedView()
                MeaningList(source: source)
            }
        }
    }
}

// MARK: - MeaningList

private struct MeaningList: View {
    var source: WordSource

    var body: some View {
        AnimatedScrollView(
            elements: source.word.meanings
        ) { _, meaning in
            MeaningListItem(meaning: meaning)
                .container()
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        WordPreviewView(word: "hello") { word in
            WordScreen(source: .api(word))
        }
    }
    .environmentObjects()
}
