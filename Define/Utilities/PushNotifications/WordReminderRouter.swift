//
//  WordReminderRouter.swift
//  Define
//
//  Created by Ben Shutt on 28/06/2024.
//

import SwiftUI

private struct WordReminderRouter: ViewModifier {
    @EnvironmentObject private var words: WordsViewModel
    @Environment(\.push) private var push

    func body(content: Content) -> some View {
        content
            .onReceive(.didReceive) { notification in
                let id = WordReminder.savedWordId(from: notification)
                guard let id, let word = words.word(for: id) else { return }
                push(.word(word.word))
            }
    }
}

// MARK: - View + Extensions

extension View {
    func routeWordReminders() -> some View {
        modifier(WordReminderRouter())
    }
}
