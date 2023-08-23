//
//  UserDefaultKey.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import Foundation

/// Keys in the `UserDefaults`
enum UserDefaultKey: String {

    /// Version number of the app
    case appVersion

    /// Has seen the welcome screen
    case hasSeenWelcome

    /// The user's saved words
    case words
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
