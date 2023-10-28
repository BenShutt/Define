//
//  Logger.swift
//  Define
//
//  Created by Ben Shutt on 28/10/2023.
//

import Foundation

protocol Logger {}

extension Logger {

    static func log(_ message: String) {
        print("[\(Self.self)] \(message)")
    }

    static func log(_ error: Error) {
        log(error.localizedDescription)
    }
}
