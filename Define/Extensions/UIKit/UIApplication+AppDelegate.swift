//
//  UIApplication+AppDelegate.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import UIKit

extension UIApplication {

    /// Get the `AppDelegate` instance
    var appDelegate: AppDelegate {
        guard let appDelegate = delegate as? AppDelegate else {
            fatalError("\(AppDelegate.self)")
        }
        return appDelegate
    }
}
