//
//  Bundle+Key.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import Foundation

extension Bundle {

    /// Fixed app keys in the `Info.plist`
    enum Key: String {

        /// App version
        case appVersion = "CFBundleShortVersionString"
    }

    /// Object for `key` casting to `T`
    ///
    /// - Parameter key: `Bundle.Key`
    func value<T>(forKey key: Bundle.Key) -> T? {
        return value(forKey: key.rawValue)
    }

    /// Object for `key` casting to `T`
    ///
    /// - Parameter key: `Bundle.Key`
    func value<T>(forKey key: String) -> T? {
        return object(forInfoDictionaryKey: key) as? T
    }

    // MARK: - Values

    /// Value for `Key.appVersion`
    var appVersion: String? {
        return value(forKey: .appVersion)
    }
}
