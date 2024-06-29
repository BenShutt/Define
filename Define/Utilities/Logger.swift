//
//  Logger.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import Foundation
import OSLog

var appNameOrDefault: String {
    Bundle.main.appName ?? "Define"
}

let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? appNameOrDefault,
    category: appNameOrDefault
)

func log(error: Error) {
    logger.error("\(error.localizedDescription)")
}
