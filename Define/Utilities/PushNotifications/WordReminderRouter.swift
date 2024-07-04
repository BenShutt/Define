//
//  WordReminderRouter.swift
//  Define
//
//  Created by Ben Shutt on 28/06/2024.
//

import SwiftUI
import SwiftData

private struct WordReminderRouter: ViewModifier {
    @Environment(\.modelContext) var modelContext
    @Environment(\.push) private var push

    private var wordDb: WordDb {
        WordDb(modelContext: modelContext)
    }

    func body(content: Content) -> some View {
        content
            .onReceive(.didReceiveNotification) { notification in
                guard let word = WordReminder.word(from: notification) else { return }
                guard let savedWord = wordDb.fetchOrNil(word: word) else { return }
                push(.word(.saved(savedWord)))
            }
    }
}

// MARK: - View + Extensions

extension View {
    func routeWordReminders() -> some View {
        modifier(WordReminderRouter())
    }
}
