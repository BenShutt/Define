//
//  AppDelegate.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import UIKit
import HTTPRequest

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
        // Enable logging for debug
        HTTPRequest.Configuration.shared.logging = Debug.isDebugging

        // Check that the API key can be loaded from the filesystem or log an error
        DictionaryAPIKey.checkKey(logger: logger)
        return true
    }
}
