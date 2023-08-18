//
//  PushNotificationManager.swift
//  Define
//
//  Created by Ben Shutt on 17/08/2023.
//

import UIKit
import UserNotifications

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
        print(userInfo) // TODO
    }

    // MARK: - Local Notification

    static func remind(in days: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = .default

        // show this notification five seconds from now
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: <#T##DateComponents#>,
            repeats: false
        )

        UNUserNotificationCenter.current().add(UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        ))
    }
}
