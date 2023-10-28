//
//  WordReminderObserver.swift
//  Define
//
//  Created by Ben Shutt on 09/10/2023.
//

import SwiftUI
import DictionaryAPI

/// Redraw UI (by updating state) when
/// - Pending notification requests updates
/// - Push notification will be presented
struct WordReminderObserver: ViewModifier {

    @EnvironmentObject var words: WordsViewModel
    @Binding var isReminderScheduled: Bool
    var word: Word

    func redrawReminder() async {
        let pendingRequests = await NotificationRequestManager.pendingRequests
        redrawReminder(pendingRequestIdentifiers: pendingRequests.map { $0.identifier })
    }

    func redrawReminder(pendingRequestIdentifiers: [String]) {
        isReminderScheduled = pendingRequestIdentifiers.contains { identifier in
            identifier == ReminderNotification.identifier(for: word)
        }
    }

    func body(content: Content) -> some View {
        content
            .task {
                await redrawReminder()
            }
            .onReminderWillPresent(words: words) { _ in
                Task {
                    await redrawReminder()
                }
            }
            .onPendingRequestsReceived { identifiers in
                redrawReminder(pendingRequestIdentifiers: identifiers)
            }
    }
}
