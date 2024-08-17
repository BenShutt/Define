//
//  UserSettings.swift
//  Define
//
//  Created by Ben Shutt on 30/06/2024.
//

import SwiftUI

@MainActor class UserSettings: ObservableObject {
    @AppStorage(.hasSeenWelcome) var hasSeenWelcome = false
    @AppStorage(.wordsExpanded) var wordsExpanded = true
    @AppStorage(.wordReminders) var wordReminders = true
}

// MARK: - UserDefaultKey

/// Keys in the `UserDefaults`
/// - Note: Useful for keeping track of what is persisted
enum UserDefaultKey: String {

    /// Version number of the app
    case appVersion

    /// Has seen the welcome screen
    case hasSeenWelcome

    /// Are the words expanded or collapsed
    case wordsExpanded

    /// Send word reminder push notifications
    case wordReminders
}

// MARK: - Extensions

extension UserDefaults {

    /// Get `Value` for `key`
    /// - Parameter key: `UserDefaultKey`
    /// - Returns: `Value`
    func value<Value>(for key: UserDefaultKey) -> Value? {
        value(forKey: key.rawValue) as? Value
    }

    /// Set `value` for `key`
    /// - Parameters:
    ///   - value: `Value`
    ///   - key: `UserDefaultKey`
    func set<Value>(_ value: Value, for key: UserDefaultKey) {
        set(value, forKey: key.rawValue)
    }
}

// MARK: - AppStorage + UserDefaultKey

extension AppStorage where Value == Bool {
    init(
        wrappedValue: Value,
        _ key: UserDefaultKey,
        store: UserDefaults? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            key.rawValue,
            store: store
        )
    }
}
