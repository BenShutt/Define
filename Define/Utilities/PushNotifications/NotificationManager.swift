//
//  NotificationManager.swift
//  Define
//
//  Created by Ben Shutt on 26/10/2023.
//

import SwiftUI
@preconcurrency import UserNotifications

/// Manage notification requests
@MainActor
class NotificationManager: ObservableObject {

    /// Set of identifiers of the pending notification requests.
    /// This property is updated when a notification request is:
    /// - Added (successfully)
    /// - Removed
    /// - Resolved (i.e. notification is received)
    @Published private(set) var identifiers: Set<String> = []

    /// The notification center to query (shorthand)
    private let center: UNUserNotificationCenter = .current()

    /// Initialize by updating the identifiers of the pending notification requests
    init() {
        updateIdentifiers()
    }

    // MARK: - Get

    /// Get all of the pending notification requests
    /// - Returns: The pending notification requests
    func requests() async -> [UNNotificationRequest] {
        await center.pendingNotificationRequests()
    }

    /// Get the pending notification request with the given identifier
    /// - Parameter identifier: The identifier of the pending notification request
    /// - Returns: The pending notification request or nil
    func request(with identifier: String) async -> UNNotificationRequest? {
        await requests().first { $0.identifier == identifier }
    }

    /// Get the next trigger date of the pending notification request with the given identifier
    /// - Warning: Requires that the pending request has a calendar trigger
    /// - Parameter identifier: The identifier of the pending notification request
    /// - Returns: The next trigger date or nil
    func nextTriggerDate(with identifier: String) async -> Date? {
        let request = await request(with: identifier)
        let trigger = request?.trigger as? UNCalendarNotificationTrigger
        return trigger?.nextTriggerDate()
    }

    // MARK: - Add

    /// Add a notification request
    /// - Parameter request: The request to add
    func add(_ request: UNNotificationRequest) async {
        do {
            try await center.add(request)
        } catch {
            log(error: error)
        }
        updateIdentifiers()
    }

    // MARK: - Remove

    /// Remove the pending notification requests with the given identifiers
    /// - Parameter identifiers: The identifiers of the pending notification requests to remove
    func remove(identifiers: [String]) {
        // Caution: This executes asynchronously on a secondary thread
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        updateIdentifiers()
    }

    // MARK: - Update

    /// Update identifiers of pending notification requests
    func updateIdentifiers() {
        Task {
            identifiers = await Set(requests().map(\.identifier))
        }
    }
}
