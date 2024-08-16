//
//  URL+Values.swift
//  Define
//
//  Created by Ben Shutt on 16/08/2024.
//

import UIKit

extension URL {
    static let sourceCode = URL(string: "https://github.com/BenShutt/Define")

    static var reportIssue: URL? {
        sourceCode?.appending(path: "issues/new")
    }

    static var appStore: URL? {
        nil // TODO: Add if used in production
    }

    static var settings: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }
}
