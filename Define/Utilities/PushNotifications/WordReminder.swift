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

    /// Key in the word reminder user info payload that maps to the word
    private static let userInfoKey = "word"

    /// Number of days to wait before sending the word reminder push notification
    private static let remindAfterDays = 3

    /// Identifier of the notification request
    /// - Parameter word: Word the notification regards
    /// - Returns: Notification identifier
    static func identifier(for word: String) -> String {
        "word_reminder_\(word)"
    }

    /// Get the word from the notification user info payload
    /// - Parameter notification: The notification received
    /// - Returns: The word or nil
    static func word(from notification: Notification) -> String? {
        notification.userInfo?[userInfoKey] as? String
    }

    /// Make a notification request for a local push notification to remind the user about a word
    /// - Parameter savedWord: The word to remind the user about
    /// - Returns: A notification request
    static func request(for savedWord: SavedWord) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = savedWord.notificationTitle
        if let subtitle = savedWord.notificationSubtitle {
            content.body = subtitle
        }
        content.sound = .default
        content.userInfo = [userInfoKey: savedWord.word]

        let calendar = Calendar.current
        let date = calendar.adding(.day, value: remindAfterDays, to: Date())
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date ?? Date()
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        return UNNotificationRequest(
            identifier: identifier(for: savedWord.word),
            content: content,
            trigger: trigger
        )
    }

    /// Add a notification request for the given word
    /// - Parameters:
    ///   - savedWord: Word to schedule the notification for
    ///   - notifications: Notification manager of requests
    @MainActor static func addRequest(
        for savedWord: SavedWord,
        on notifications: NotificationManager
    ) {
        Task { await notifications.add(request(for: savedWord)) }
    }

    /// Remove the notification request for the given word
    /// - Parameters:
    ///   - savedWord: Word to remove the notification for
    ///   - notifications: Notification manager of requests
    @MainActor static func removeRequest(
        for savedWord: SavedWord,
        on notifications: NotificationManager
    ) {
        notifications.remove(identifiers: [identifier(for: savedWord.word)])
    }
}
