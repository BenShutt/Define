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
    static let wordIdKey = "\(ReminderNotification.self).word.id"

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
        content.title = word.notificationTitle.value // TODO: Fix localization
        if let subtitle = word.notificationSubtitle {
            content.body = subtitle.value
        }
        content.sound = .default
        content.userInfo[wordIdKey] = word.id

        let date = Calendar.current.addingDays(remindAfterDays, to: Date())
        let dateComponents = Calendar.current.dateTimeComponents(from: date)

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        UNUserNotificationCenter.current().add(UNNotificationRequest(
            identifier: notificationId(for: word),
            content: content,
            trigger: trigger
        )) { error in
            if let error {
                print("[\(ReminderNotification.self)] \(error)")
            }
        }
    }

    /// Get the `Word` from the given `notification`
    /// - Parameters:
    ///   - notification: `Notification`
    ///   - words: `WordsViewModel`
    /// - Returns: `Word` if found, otherwise `nil`
    static func word(
        from notification: Notification,
        words: WordsViewModel
    ) -> Word? {
        let wordId = notification.userInfo?[wordIdKey] as? String
        return words.words.first { $0.word.id == wordId }?.word
    }

    /// Get the pending `UNNotificationRequest` for `word` or `nil` if it is not pending
    /// - Parameter word: `Word` to remind of
    /// - Returns: The notification request
    static func pendingRequest(word: Word) async -> UNNotificationRequest? {
        let notificationId = notificationId(for: word)
        let center = UNUserNotificationCenter.current()
        return await center.pendingNotificationRequests().first { request in
            request.identifier == notificationId
        }
    }

    /// Get the next trigger date for the given `word`
    /// - Parameter word: `Word`
    /// - Returns: `Date`
    static func nextTriggerDate(for word: Word) async -> Date? {
        let pendingRequest = await pendingRequest(word: word)
        guard let trigger = pendingRequest?.trigger else { return nil }
        guard let calendarTrigger = trigger as? UNCalendarNotificationTrigger else { return nil }
        return calendarTrigger.nextTriggerDate()
    }

    /// Remove the request for `word`
    /// - Parameter word: `Word` to remind of
    static func removePendingRequest(word: Word) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [ notificationId(for: word) ]
        )
    }
}

// MARK: - View + ReminderNotification

extension View {

    func onReminderDidReceive(
        words: WordsViewModel,
        perform action: @escaping (Word) -> Void
    ) -> some View {
        onReceive(.didReceive) { notification in
            let word = ReminderNotification.word(from: notification, words: words)
            guard let word else { return }
            action(word)
        }
    }

    func onReminderWillPresent(
        words: WordsViewModel,
        perform action: @escaping (Word) -> Void
    ) -> some View {
        onReceive(.willPresent) { notification in
            let word = ReminderNotification.word(from: notification, words: words)
            guard let word else { return }
            action(word)
        }
    }
}
