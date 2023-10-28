//
//  NotificationRequestManager.swift
//  Define
//
//  Created by Ben Shutt on 26/10/2023.
//

import SwiftUI
import UserNotifications

/// Manage notification requests
struct NotificationRequestManager: Logger {

    /// The notification center to operate on
    private static let center: UNUserNotificationCenter = .current()

    /// Add a notification request
    /// - Parameter request: The request
    static func add(_ request: UNNotificationRequest) {
        center.add(request) { error in
            if let error {
                log(error)
            } else {
                postNotification()
            }
        }
    }

    static var pendingRequests: [UNNotificationRequest] {
        get async {
            await center.pendingNotificationRequests()
        }
    }

    /// Get the pending request with the given identifier
    /// - Parameter identifier: The identifier
    /// - Returns: The notification request or nil
    static func pendingRequest(with identifier: String) async -> UNNotificationRequest? {
        await center.pendingNotificationRequests().first { request in
            request.identifier == identifier
        }
    }

    /// Get the next trigger date with the given identifier
    /// - Parameter identifier: The identifier
    /// - Returns: The next trigger date or nil
    static func nextTriggerDate(with identifier: String) async -> Date? {
        let pendingRequest = await pendingRequest(with: identifier)
        guard let trigger = pendingRequest?.trigger else { return nil }
        guard let calendarTrigger = trigger as? UNCalendarNotificationTrigger else { return nil }
        return calendarTrigger.nextTriggerDate()
    }

    /// Remove the pending requests with the given identifiers
    /// - Parameter identifiers: The identifiers of the pending requests to remove
    static func removePending(with identifiers: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        postNotification()
    }

    /// Post on the notification center the updated pending requests
    private static func postNotification() {
        Task { @MainActor in
            let pendingRequests = await center.pendingNotificationRequests()
            NotificationCenter.default.post(
                name: .pendingRequests,
                object: nil,
                userInfo: UserInfo(pendingRequests: pendingRequests)
            )
        }
    }
}

// MARK: - UserInfo + Extensions

private extension UserInfo {

    /// The user info key
    private static let key = "pendingRequests"

    /// Map the given pending requests to a user info
    /// - Parameter pendingRequests: The pending requests
    init(pendingRequests: [UNNotificationRequest]) {
        self = [Self.key: pendingRequests.map { $0.identifier }]
    }

    /// Get the pending request identifiers from the given user info
    var pendingRequestIdentifiers: [String] {
        (self[Self.key] as? [String]) ?? []
    }
}

// MARK: - Notification.Name + Extensions

private extension Notification.Name {

    /// Name of the notification that the pending requests are posted on
    static let pendingRequests = Self(
        rawValue: "\(NotificationRequestManager.self).pendingRequests"
    )
}

// MARK: - View + Extensions

extension View {

    func onPendingRequestsReceived(
        perform action: @escaping ([String]) -> Void
    ) -> some View {
        onReceive(.pendingRequests) { notification in
            let userInfo = notification.userInfo ?? [:]
            action(userInfo.pendingRequestIdentifiers)
        }
    }
}
