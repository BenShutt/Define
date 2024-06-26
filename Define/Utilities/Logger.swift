//
//  Logger.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import Foundation
import OSLog

let logCategory = Bundle.main.appName ?? "Define"

let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? logCategory,
    category: logCategory
)

func log(error: Error) {
    logger.error("\(error.localizedDescription)")
}
