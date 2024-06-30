//
//  PushNotificationManager.swift
//  Define
//
//  Created by Ben Shutt on 17/08/2023.
//

import SwiftUI
import UserNotifications
import DictionaryAPI

/// Manage push notifications
struct PushNotificationManager {

    // MARK: - Authorization

    /// Request permission to send this device remote push notification
    /// - Parameter completion: Completion called on request
    static func requestRemoteNotificationPermission(
        completion: @escaping (Bool) -> Void
    ) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            logger.info("Push notification authorization: \(granted)")
            if let error { log(error: error) }
            completion(granted && error == nil)
        }
    }

    // MARK: - Remote Notifications

    static func didRegisterForRemoteNotifications(with deviceToken: Data) {
        let apnsToken = deviceToken
            .map { String(format: "%02.2hhx", $0) }
            .joined()

        logger.info("APNs token: \(apnsToken)")
    }

    static func didFailToRegisterForRemoteNotifications(with error: Error) {
        log(error: error)
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
        NotificationCenter.default.post(
            name: .didReceive,
            object: nil,
            userInfo: response.notification.request.content.userInfo
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
    ///   - center: The notification center, defaulted
    ///   - object: The object, defaults to nil
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
