//
//  PushNotificationManager.swift
//  Define
//
//  Created by Ben Shutt on 17/08/2023.
//

import UIKit
import UserNotifications
import DictionaryAPI

/// Manage push notifications
struct PushNotificationManager {

    private static let remindAfterDays = 3
    private static let wordUserInfoKey = "word"

    // MARK: - Authorization

    /// Request permission to send this device remote push notification
    static func requestRemoteNotificationPermission() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: options
        ) { granted, error in
            print("Push notification authorization: \(granted)")
            if let error {
                print("Push notification authorization error: \(error)")
            }
        }

        // UIApplication.shared.registerForRemoteNotifications()
    }

    // MARK: - UNNotificationCenter

    /// Called on `userNotificationCenter(_:willPresent:)`
    /// - Parameter notification: `UNNotification`
    /// - Returns: `UNNotificationPresentationOptions`
    static func willPresent(
        notification: UNNotification
    ) -> UNNotificationPresentationOptions {
        [.list, .banner, .badge, .sound]
    }

    /// Called on `userNotificationCenter(_:didReceive:)`
    /// - Parameter response: `UNNotificationResponse`
    static func didReceive(response: UNNotificationResponse) {
        let userInfo = response.notification.request.content.userInfo
        if let word = userInfo[wordUserInfoKey] as? Word {
            NavigationViewModel.shared.push(.word(word))
        }
    }

    // MARK: - Local Notification

    /// Send a local push notification to remind the user about a word in `remindAfterDays` days
    /// - Parameter word: The word to remind the user about
    static func remind(word: Word) {
        let content = UNMutableNotificationContent()
        content.title = .Push.title(word: word.word)
        content.subtitle = .Push.subtitle
        content.sound = .default
        content.userInfo[wordUserInfoKey] = word

        let date = Calendar.current.date(
            byAdding: .day,
            value: remindAfterDays,
            to: Date()
        ) ?? Date()

        let dateComponents = Calendar.current.dateComponents(
            in: .current,
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        UNUserNotificationCenter.current().add(UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        ))
    }
}
