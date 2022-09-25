//
//  Loggable.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import Foundation
import os

/// Wrapper of an `OSLog` instance
protocol Loggable {

    /// `OSLog`
    var logger: OSLog { get }
}

// MARK: - Extensions

extension Loggable {

    /// Log `message` of `type`
    ///
    /// - Note:
    /// `os_log` is safe to call from any thread
    ///
    /// - Parameters:
    ///   - type: `OSLogType`
    ///   - message: `String`
    func log(type: OSLogType, message: String) {
        os_log(type, log: logger, "%@", message)
    }

    /// Log `error`
    ///
    /// - Parameter error: `Error`
    func log(error: Error) {
        log(type: .error, message: error.localizedDescription)
    }
}
