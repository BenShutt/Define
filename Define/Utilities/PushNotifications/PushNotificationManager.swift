//
//  PushNotificationManager.swift
//  Define
//
//  Created by Ben Shutt on 17/08/2023.
//

import UIKit
import UserNotifications
import DictionaryAPI

/// PN payload
typealias UserInfo = [AnyHashable: Any]

/// Manage push notifications
struct PushNotificationManager {

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
        NotificationCenter.default.post(
            name: .didReceive,
            object: nil,
            userInfo: userInfo
        )
    }
}

// MARK: - Notification.Name + Extensions

extension Notification.Name {

    /// Push notification received
    static let didReceive = Notification.Name(rawValue: "didReceive")
}
