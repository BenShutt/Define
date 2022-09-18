//
//  URL+Components.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

extension URL {

    /// Extension of Xcode project
    private static let xcodeproj = "xcodeproj"

    /// Find directory containing the `xcodeproj` file
    /// - Returns: `URL`
    static func findDirectoryOfXcodeProject() throws -> URL {
        var url = URL(fileURLWithPath: #file)
        while url.pathComponents.count > 1 {
            url.deleteLastPathComponent()
            if try url.containsXcodeProject() {
                return url
            }
        }

        throw FileError.fileNotFound
    }

    /// Does this directory contain the `xcodeproj` file (by checking file extension)
    /// - Returns: `Bool`
    private func containsXcodeProject() throws -> Bool {
        return try FileManager.default
            .contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
            .contains { $0.pathExtension == Self.xcodeproj }
    }
}

// MARK: - FileError

/// `Error` with a file `URL`
enum FileError: Error {

    /// Failed to find a file
    case fileNotFound
}
