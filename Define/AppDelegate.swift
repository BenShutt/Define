//
//  AppDelegate.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import UIKit

/// Implementation of `UIApplicationDelegate`
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    /// Lauch options dictionary
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil
    ) -> Bool {
        // Configure push notifications
        UNUserNotificationCenter.current().delegate = self

        // Run any migrations before launching the app
        Migrations.execute()
        return true
    }

    // MARK: - Push Notifications

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let apnsToken = deviceToken
            .map { String(format: "%02.2hhx", $0) }
            .joined()
        log("APNs token: \(apnsToken)")
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        log("\(#function) \(error)")
    }

    // MARK: - UNUserNotificationCenterDelegate

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        PushNotificationManager.willPresent(notification: notification)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        PushNotificationManager.didReceive(response: response)
    }

    // MARK: - Logging

    private func log(_ message: String) {
        print("[\(Self.self)] \(message)")
    }
}
