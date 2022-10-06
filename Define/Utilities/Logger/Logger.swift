//
//  Logger.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import Foundation
import os

/// Basic structure conforming to `Loggable`
struct Logger: Loggable {

    /// Shared application logger
    static let shared = Logger(tag: "Define")

    /// `OSLog` instance
    let logger: OSLog

    /// Initialize with `tag`
    ///
    /// - Parameter tag: `String`
    init(tag: String) {
        self.init(logger: OSLog(tag: tag))
    }

    /// Memberwise initializer
    ///
    /// - Parameter logger: `OSLog`
    init(logger: OSLog) {
        self.logger = logger
    }
}
