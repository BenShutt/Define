//
//  AppDelegate.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import UIKit

/// Implementation of `UIApplicationDelegate`
class AppDelegate: NSObject, UIApplicationDelegate {

    /// Lauch options dictionary
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil
    ) -> Bool {
        Migrations.execute()
        return true
    }
}
