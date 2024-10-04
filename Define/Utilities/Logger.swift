//
//  Logger.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import Foundation
import OSLog

let logger = Logger(
    subsystem: Configuration.bundleIdentifier,
    category: appName
)

func log(error: Error) {
    logger.error("\(error.localizedDescription)")
}
