//
//  AppDelegate.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import UIKit

/// Implementation of `UIApplicationDelegate`
class AppDelegate: NSObject, UIApplicationDelegate {

    /// Application `Logger`
    private let logger = Logger(tag: "\(AppDelegate.self)")

    /// Lauch options dictionary
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil
    ) -> Bool {
        DictionaryAPIKey.checkKey(logger: logger)
        return true
    }
}
