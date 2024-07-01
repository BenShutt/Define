//
//  WordReminder.swift
//  Define
//
//  Created by Ben Shutt on 26/09/2023.
//

import SwiftUI
import UserNotifications
import DictionaryAPI

/// Wraps the logic of reminder push notifications
struct WordReminder {

    /// Key in the word reminder user info payload that maps to the saved word ID
    private static let userInfoKey = "saved_word_id"

    /// Number of days to wait before sending the word reminder push notification
    private static let remindAfterDays = 3

    /// Identifier of the notification request
    /// - Parameter id: ID of the saved word
    /// - Returns: Notification identifier
    static func identifier(for id: SavedWordId) -> String {
        "word_reminder_\(id.uuidString.lowercased())"
    }

    /// Get the ID of the saved word from the notification user info payload
    /// - Parameter notification: Notification received
    /// - Returns: The ID of the saved word or nil
    static func savedWordId(from notification: Notification) -> SavedWordId? {
        let uuidString = notification.userInfo?[userInfoKey] as? String
        guard let uuidString else { return nil }
        return UUID(uuidString: uuidString)
    }

    /// Make a notification request for a local push notification to remind the user about a word
    /// - Parameter word: The word to remind the user about
    /// - Returns: A notification request
    static func request(for word: SavedWord) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = word.word.notificationTitle
        if let subtitle = word.word.notificationSubtitle {
            content.body = subtitle
        }
        content.sound = .default
        content.userInfo = [userInfoKey: word.id.uuidString]

        let calendar = Calendar.current
        let date = calendar.adding(.day, value: remindAfterDays, to: Date())
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        return UNNotificationRequest(
            identifier: identifier(for: word.id),
            content: content,
            trigger: trigger
        )
    }

    /// Add a notification request for the given word
    /// - Parameters:
    ///   - word: Saved word to schedule a notification for
    ///   - notifications: Notification manager of requests
    @MainActor static func addRequest(
        for word: SavedWord,
        on notifications: NotificationManager
    ) {
        Task { await notifications.add(request(for: word)) }
    }

    /// Remove the notification request for the given word
    /// - Parameters:
    ///   - word: Saved word to schedule a notification for
    ///   - notifications: Notification manager of requests
    @MainActor static func removeRequest(
        for wordId: SavedWordId,
        on notifications: NotificationManager
    ) {
        notifications.remove(identifiers: [identifier(for: wordId)])
    }
}
