//
//  Migrations.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import Foundation

/// Run migrations
struct Migrations {

    /// Get and set app version in `UserDefaults`
    static var appVersion: String? {
        get {
            UserDefaults.standard.value(for: .appVersion)
        }
        set {
            UserDefaults.standard.set(newValue, for: .appVersion)
        }
    }

    /// Check the previous app version against the current app version and perform
    /// migrations accordingly
    static func execute() {
        // Get appVersion the app was last launched with
        let previousAppVersion = appVersion

        // Get the current appVersion
        guard let currentAppVersion = Bundle.main.appVersion else { return }

        // Persist the current appVersion
        appVersion = currentAppVersion

        // Check the previous and current appVersions are different
        guard currentAppVersion != previousAppVersion else { return }

        // If they are different, handle migrations
        handleMigrations(from: previousAppVersion, to: currentAppVersion)
    }

    /// Migrate from `oldVersion` to `newVersion`
    ///
    /// - Parameters:
    ///   - oldVersion: `String` old version
    ///   - newVersion: `String` new version
    private static func handleMigrations(
        from oldVersion: String?, to newVersion: String
    ) {
        // Can be used to implement migrations
    }
}
