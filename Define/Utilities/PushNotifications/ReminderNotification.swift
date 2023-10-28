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

    /// Identifier of the push notification request
    /// - Parameter word: `Word` that is scheduled
    /// - Returns: Identifier
    static func identifier(for word: Word) -> String {
        "word_reminder_\(word.id)"
    }

    /// Send a local push notification to remind the user about a word
    /// - Parameter word: The word to remind the user about
    static func scheduleRequest(word: Word) {
        let identifier = identifier(for: word)

        let content = UNMutableNotificationContent()
        content.title = word.notificationTitle.value
        if let subtitle = word.notificationSubtitle {
            content.body = subtitle.value
        }
        content.sound = .default
        content.userInfo = UserInfo(identifier: identifier)

        let date = Calendar.current.adding(.day, value: remindAfterDays, to: Date())
        let dateComponents = Calendar.current.dateTimeComponents(from: date)

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        NotificationRequestManager.add(UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        ))
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
        words.words
            .first { $0.word.id == notification.userInfo?.identifier }?
            .word
    }

    /// Remove the request for `word`
    /// - Parameter word: `Word` to remind of
    static func removePendingRequest(word: Word) {
        NotificationRequestManager.removePending(with: [identifier(for: word)])
    }
}

// MARK: - UserInfo + Extensions

private extension UserInfo {

    private static let key = "identifier"

    init(identifier: String) {
        self = [Self.key: identifier]
    }

    var identifier: String? {
        self[Self.key] as? String
    }
}

// MARK: - View + Extensions

extension View {

    func onReminderDidReceive(
        words: WordsViewModel,
        perform action: @escaping (Word) -> Void
    ) -> some View {
        onReceive(.didReceive) { notification in
            if let word = ReminderNotification.word(from: notification, words: words) {
                action(word)
            }
        }
    }

    func onReminderWillPresent(
        words: WordsViewModel,
        perform action: @escaping (Word) -> Void
    ) -> some View {
        onReceive(.willPresent) { notification in
            if let word = ReminderNotification.word(from: notification, words: words) {
                action(word)
            }
        }
    }
}
