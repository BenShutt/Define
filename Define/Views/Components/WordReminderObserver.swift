//
//  WordReminderObserver.swift
//  Define
//
//  Created by Ben Shutt on 09/10/2023.
//

import SwiftUI
import DictionaryAPI

// TODO: Perhaps we only need to pass in a @Binding, protocol not needed?

/// A view which should redraw when a reminder PN is received.
/// The view should also ensure it's UI correctly reflects the pending notification requests.
protocol WordReminderObserver: View {

    /// Is the notification request reminding the user about this word pending (due in the future)
    var isReminderScheduled: Bool { get nonmutating set }
}

extension WordReminderObserver {

    /// Update the local state in an asynchronous context
    /// - Parameter word: `Word` to check is scheduled
    func updateReminder(word: Word) async {
        let pendingRequest = await ReminderNotification.pendingRequest(word: word)
        isReminderScheduled = pendingRequest != nil
    }

    /// Update the local state by dispatching a task
    /// - Parameter word: `Word` to check is scheduled
    func updateReminderAsync(word: Word) {
        Task {
            await updateReminder(word: word)
        }
    }
}

// MARK: - View + WordReminderObserver

extension View {

    /// Update a view so that it observes word reminder PNs
    func observeWordReminder(
        observer: some WordReminderObserver,
        word: Word,
        words: WordsViewModel
    ) -> some View {
        task {
            await observer.updateReminder(word: word)
        }
        .onReminderWillPresent(words: words) { _ in
            observer.updateReminderAsync(word: word)
        }
    }
}
