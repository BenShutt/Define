//
//  Logger.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 25/09/2022.
//

import Foundation
import os

/// Basic structure conforming to `Loggable`
public struct Logger: Loggable {

    /// `OSLog` instance
    public let logger: OSLog

    /// Initialize with `tag`
    ///
    /// - Parameter tag: `String`
    public init(tag: String) {
        self.init(logger: OSLog(
            subsystem: Bundle.main.bundleIdentifier ?? tag,
            category: tag
        ))
    }

    /// Memberwise initializer
    ///
    /// - Parameter logger: `OSLog`
    private init(logger: OSLog) {
        self.logger = logger
    }
}
