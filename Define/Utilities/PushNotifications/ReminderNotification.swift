//
//  ReminderNotification.swift
//  Define
//
//  Created by Ben Shutt on 26/09/2023.
//

import SwiftUI
import UserNotifications
import DictionaryAPI

/// Wraps the logic of reminder push notifications
final class ReminderNotification: ObservableObject {

    /// Number of days to wait before sending the word reminder push notification
    static let remindAfterDays = 3

    /// The user info key for the word
    static let wordIdKey = "\(ReminderNotification.self).wordId"

    /// Shorthand to get the current notification center
    private static let center: UNUserNotificationCenter = .current()

    /// Identifier of the push notification request
    /// - Parameter word: `Word` that is scheduled
    /// - Returns: Identifier
    private static func notificationId(for word: Word) -> String {
        "word_reminder_\(word.id)"
    }

    /// Send a local push notification to remind the user about a word
    /// - Parameter word: The word to remind the user about
    static func scheduleRequest(word: Word) {
        let content = UNMutableNotificationContent()
        content.title = word.title
        if let subtitle = word.notificationSubtitle {
            content.subtitle = subtitle.value
        }
        content.sound = .default
        content.userInfo[wordIdKey] = word.id

        let date = Calendar.current.addingDays(remindAfterDays, to: Date())
        let dateComponents = Calendar.current.dateComponents(
            in: .current,
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        center.add(UNNotificationRequest(
            identifier: notificationId(for: word),
            content: content,
            trigger: trigger
        ))
    }

    /// Get the pending `UNNotificationRequest` for `word` or `nil` if it is not pending
    /// - Parameter word: `Word` to remind of
    /// - Returns: The notification request
    static func pendingRequest(word: Word) async -> UNNotificationRequest? {
        let notificationId = notificationId(for: word)
        return await center.pendingNotificationRequests().first { request in
            request.identifier == notificationId
        }
    }

    /// Remove the request for `word`
    /// - Parameter word: `Word` to remind of
    static func removePendingRequest(word: Word) {
        center.removePendingNotificationRequests(
            withIdentifiers: [ notificationId(for: word) ]
        )
    }
}

// MARK: - View + ReminderNotification

extension View {

    func onReminderReceived(
        words: WordsViewModel,
        perform action: @escaping (Word) -> Void
    ) -> some View {
        onReceive { notification in
            let wordIdKey = ReminderNotification.wordIdKey
            let wordId = notification.userInfo?[wordIdKey] as? String
            let word = words.words.first { $0.word.id == wordId }
            guard let word else { return }
            action(word.word)
        }
    }
}
