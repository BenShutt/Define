//
//  PushNotificationManager.swift
//  Define
//
//  Created by Ben Shutt on 17/08/2023.
//

import SwiftUI
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
        NotificationCenter.default.post(
            name: .willPresent,
            object: nil,
            userInfo: notification.request.content.userInfo
        )
        return [.list, .banner, .badge, .sound]
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

    /// Push notification will present
    static let willPresent = Notification.Name(
        rawValue: "\(PushNotificationManager.self).willPresent"
    )

    /// Push notification did received
    static let didReceive = Notification.Name(
        rawValue: "\(PushNotificationManager.self).didReceive"
    )
}

// MARK: - View + Notification.Name

extension View {

    /// Perform an action when a PN is received from a view
    /// - Parameters:
    ///   - name: Notification name
    ///   - center: The notification center
    ///   - object: The object
    ///   - action: Action to perform
    /// - Returns: A view
    func onReceive(
        _ name: Notification.Name,
        center: NotificationCenter = .default,
        object: AnyObject? = nil,
        perform action: @escaping (Notification) -> Void
    ) -> some View {
        onReceive(
            center.publisher(for: name, object: object),
            perform: action
        )
    }
}
