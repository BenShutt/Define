//
//  DefineApp.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import SwiftUI

/// `App` implementation
@main
struct DefineApp: App {

    /// `AppDelegate`
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    /// Make `Scene`
    var body: some Scene {
        WindowGroup {
            EnterWordScreen()
        }
    }
}
