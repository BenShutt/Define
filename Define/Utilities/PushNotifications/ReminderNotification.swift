//
//  ReminderNotification.swift
//  Define
//
//  Created by Ben Shutt on 26/09/2023.
//

import SwiftUI
import UserNotifications
import DictionaryAPI

// TODO: Sync this file with the PushNotificationManager

/// Wraps the logic of reminder push notifications
final class ReminderNotification: ObservableObject {

    /// Number of days to wait before sending the word reminder push notification
    private static let remindAfterDays = 3

    /// Shorthand to get the current notification center
    private static var center: UNUserNotificationCenter {
        .current()
    }

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
        // TODO: content.subtitle
        content.sound = .default

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
