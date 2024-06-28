//
//  WordReminderRouter.swift
//  Define
//
//  Created by Ben Shutt on 28/06/2024.
//

import SwiftUI

// MARK: - WordReminderRouter

private struct WordReminderRouter: ViewModifier {
    @EnvironmentObject private var words: WordsViewModel
    @EnvironmentObject private var tabRequest: TabRequestPublisher

    func body(content: Content) -> some View {
        content
            .onReceive(.didReceive) { notification in
                let id = WordReminder.savedWordId(from: notification)
                guard let id, let word = words.word(for: id) else { return }
                tabRequest.open(tab: .home) { push, _ in
                    push(.word(word.word))
                }
            }
    }
}

// MARK: - View + Extensions

extension View {
    func routeWordReminders() -> some View {
        modifier(WordReminderRouter())
    }
}
